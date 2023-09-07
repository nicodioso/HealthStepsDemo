//
//  DayStepActivity+CoreDataProcessing.swift
//  MySteps
//
//  Created by Nico Dioso on 8/8/23.
//

import CoreData

extension DayStepActivity {
    static func getPersistentData(for monthDate: Date, context: NSManagedObjectContext) -> [DayStepActivity] {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: monthDate)
        let year = calendar.component(.year, from: monthDate)
        
        let fetchRequest = CoreDataDayStep.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "month == %@ && year == %@", NSNumber(value: month), NSNumber(value: year))
        fetchRequest.sortDescriptors = [.init(key: #keyPath(CoreDataDayStep.date), ascending: true)]
        do {
            let result = try context.fetch(fetchRequest)
            return result.compactMap { one in
                let monthDay = calendar.component(.day, from: one.date)
                return .init(monthDay: Int(monthDay), stepCount: Int(one.count))
            }
        } catch {
            print("CoreData fetch error", error)
            return []
        }
    }
}

extension Array where Element == DayStepActivity {
    
    func save(month: Int, year: Int, toContext context: NSManagedObjectContext) {
        self.forEach { stepActivity in
            let components = DateComponents(year: year, month: month, day: stepActivity.monthDay)
            guard let date = Calendar.current.date(from: components) else { return }
            let dayStep = CoreDataDayStep(context: context)
            dayStep.count = Int64(stepActivity.stepCount)
            dayStep.date = date
            dayStep.month = Int16(month)
            dayStep.year = Int16(year)
        }
        try? context.save()
    }
}

extension CoreDataDayStep {
    /// Deletes every entry recorded on the date provided.
    static func deleteData(onDate date: Date, context: NSManagedObjectContext) {
        let fetchRequest = CoreDataDayStep.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date >= %@ && date <= %@", date.startOfDay as CVarArg, date.endOfDay as CVarArg)
        fetchRequest.includesPropertyValues = false
        let objects = try? context.fetch(fetchRequest)
        for object in objects ?? [] {
            context.delete(object)
        }
    }
}
