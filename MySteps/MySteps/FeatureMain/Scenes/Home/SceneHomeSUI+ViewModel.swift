//
//  SceneHomeSUI+ViewModel.swift
//  MySteps
//
//  Created by Nico Dioso on 8/5/23.
//

import Foundation
import HealthKitUI
import CoreData
import SwiftUI


extension SceneHomeSUI {
    @MainActor
    class ViewModel: BaseVM {
        
        @Published var monthStepData = MonthStepsData(
            monthDate: Date().firstDayOfTheMonth,
            data: []
        )
        @Published var achievements: [Achievement] = []
        @Published var error: LocalizedError? = nil
        
        private let healthStore = HKHealthStore()
        private let calendar = Calendar.current
        
        func handleTap(of achievement: Achievement) {
            navigate(to: HomeDestination.achievement(data: achievement))
        }
        
        func setupHealthKit() {
            if HKHealthStore.isHealthDataAvailable() {
                Task {
                    let stepCount = HKQuantityType(.stepCount)
                    do {
                        let authStatus = healthStore.authorizationStatus(for: stepCount)
                        switch authStatus {
                        case .notDetermined:
                            try await healthStore.requestAuthorization(toShare: [stepCount], read: [stepCount])
                            processStepCountData(isInitialRun: true)
                        case .sharingDenied:
                            throw VMError.userDeniedAuthorization
                        case .sharingAuthorized:
                            processStepCountData()
                        @unknown default:
                            throw VMError.genericError
                        }
                    } catch {
                        handle(error: error)
                    }
                }
            } else {
                handle(error: VMError.healthKitError)
            }
        }
        
        func setupAchievements(isInitialRun: Bool) {
            var achievements: [Achievement] = []
            let context = persistence.container.viewContext
            if isInitialRun {
                let monthAchievements = createCurrentMonthAchievements(andSaveTo: context)
                achievements = monthAchievements
            } else {
                let storedAchievements = Achievement
                    .getPersistentData(onContext: context)
                    .parseData()
                let newAchievements = checkForNewAchievements(excluding: storedAchievements.map{ $0.type })
                newAchievements.save(toCoreDataContext: context)
                achievements = storedAchievements + newAchievements
            }
            do {
                try context.save()
            } catch {
                handle(error: VMError.genericError)
            }
            self.achievements = achievements.sorted(by: { $0.completionDate > $1.completionDate })
        }
        
        private func createCurrentMonthAchievements(andSaveTo context: NSManagedObjectContext) -> [Achievement] {
            let currentMonthDate = Date.now.firstDayOfTheMonth
            var monthStepsSoFar = 0
            var types = AchievementType.allCases
            var monthAchievements: [Achievement] = []
            monthStepData.data.forEach { activity in
                guard let date = calendar.date(bySetting: .day, value: activity.monthDay, of: currentMonthDate)
                else {
                    print("Failed to create date for \(currentMonthDate)")
                    handle(error: VMError.genericError)
                    return
                }
                monthStepsSoFar += activity.stepCount
                let achievements = types.removeAchievements(forStepCount: monthStepsSoFar)
                monthAchievements += achievements.map{ .init(type: $0, completionDate: date) }
            }
            monthAchievements.save(toCoreDataContext: context)
            return monthAchievements
        }
        
        private func checkForNewAchievements(excluding excludedTypes: [AchievementType]) -> [Achievement] {
            var currentAchievementsDict: [AchievementType: Bool] = [:]
            excludedTypes.forEach { currentAchievementsDict[$0] = true }
            var availableAchievementTypes = AchievementType.allCases.compactMap {
                currentAchievementsDict[$0] == nil ? $0: nil
            }
            let newAchievements = availableAchievementTypes
                .removeAchievements(forStepCount: monthStepData.totalSteps)
                .map{ Achievement(type: $0, completionDate: .now) }
            return newAchievements
        }
        
        private func handle(error: Error) {
            if let localizedError = error as? LocalizedError {
                self.error = localizedError
            } else {
                self.error = VMError.genericError
            }
        }
        
        private func processStepCountData(isInitialRun: Bool = false) {
            Task {
                let context = persistence.container.viewContext
                let now = Date.now
                monthStepData.data = DayStepActivity.getPersistentData(
                    for: now,
                    context: context
                )
                let storedDataHasMonthDay1 = monthStepData.data.first(where: { $0.monthDay == 1 }) != nil
                let isNowFirstDayOftheMonth = calendar.component(.day, from: now) == 1
                let isNeededToGetFromMonthDay1 = !isNowFirstDayOftheMonth && !storedDataHasMonthDay1

                let datesToReadStep = isNeededToGetFromMonthDay1 ? getDatesFromStartOfMonth(): [now]
                var daySteps: [DayStepActivity] = []
                await datesToReadStep.asyncForEach{ date in
                    do {
                        let stepCount = try await readStepCount(for: date)
                        let monthday = calendar.component(.day, from: date)
                        daySteps.append(.init(monthDay: monthday, stepCount: Int(stepCount)))
                    } catch {
                        handle(error: VMError.genericError)
                    }
                }
                CoreDataDayStep.deleteData(onDate: .now, context: context)
                let month = calendar.component(.month, from: now)
                let year = calendar.component(.year, from: now)

                daySteps.save(
                    month: month,
                    year: year,
                    toContext: persistence.container.viewContext
                )
                monthStepData.data += daySteps
                setupAchievements(isInitialRun: isInitialRun)
            }
        }
        
        private func getDatesFromStartOfMonth() -> [Date] {
            let now = Date.now
            let dayToday = calendar.component(.day, from: .now)
            let monthDays = Array(0..<dayToday)
            let firstDayOftheMonth = now.firstDayOfTheMonth
            
            var dates: [Date] = []
            monthDays.forEach { day in
                if let date = calendar.date(byAdding: .day, value: day, to: firstDayOftheMonth) {
                    dates.append(date)
                }
            }
            return dates
        }
        
        private func readStepCount(for date: Date) async throws -> Double {
            guard let stepQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)
            else { throw VMError.healthKitError }
            
            let predicate = HKQuery.predicateForSamples(withStart: date.startOfDay, end: date.endOfDay, options: .strictStartDate)
            
            return await withCheckedContinuation { continuation in
                healthStore.execute(
                    HKStatisticsQuery(quantityType: stepQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
                        guard let result = result, let sum = result.sumQuantity()
                        else {
                            continuation.resume(with: .success(0))
                            return
                        }
                        continuation.resume(with: .success(sum.doubleValue(for: HKUnit.count())))
                    }
                )
            }
        }
    }
}

extension SceneHomeSUI.ViewModel {
    enum VMError: LocalizedError {
        case userDeniedAuthorization, dateError, healthKitError, genericError
        
        var errorDescription: String? {
            switch self {
            case .userDeniedAuthorization:
                return "Permissions required".localized()
            default:
                return "Something went wrong"
            }
        }

        var recoverySuggestion: String? {
            switch self {
            case .userDeniedAuthorization:
                return "It seems like you declined HealthKit permissions for our app. To fix this, just go to your device's 'Settings', then select 'Health' inside, tap 'Data Access & Devices', find 'MySteps' and ensure 'Read and Write' is turned on. After that, reopen our app for a seamless experience.".localized()
            default:
                return "An unexpected error happened.".localized()
            }
        }
    }
}
