//
//  Achievement+CoreDataProcessing.swift
//  MySteps
//
//  Created by Nico Dioso on 8/8/23.
//

import CoreData

extension Achievement {
    static func getPersistentData(onContext context: NSManagedObjectContext) -> [CoreDataAchievement] {
        do {
            let fetchRequest = CoreDataAchievement.fetchRequest()
            let results = try context.fetch(fetchRequest)
            fetchRequest.sortDescriptors = [.init(key: #keyPath(CoreDataAchievement.completionDate), ascending: true)]
            return results
        } catch {
            print("Failed to get Achievement CoreData data")
            return []
        }
    }
}

extension Array where Element == Achievement {
    func save(toCoreDataContext context: NSManagedObjectContext) {
        forEach { achievement in
            let cdAchievement = CoreDataAchievement(context: context)
            cdAchievement.type = Int16(achievement.type.rawValue)
            cdAchievement.completionDate = achievement.completionDate
        }
    }
}

extension Array where Element == CoreDataAchievement {
    func parseData() -> [Achievement] {
        return compactMap { result -> Achievement? in
            guard let type = AchievementType(rawValue: Int(result.type)) else { return nil }
            return .init(type: type, completionDate: result.completionDate)
        }
    }
    
    func deleteAll(on context: NSManagedObjectContext) {
        forEach { achievement in
            context.delete(achievement)
        }
    }
}
