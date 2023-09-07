//
//  CoreDataAchievement+CoreDataProperties.swift
//  MySteps
//
//  Created by Nico Dioso on 8/8/23.
//
//

import Foundation
import CoreData


extension CoreDataAchievement {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataAchievement> {
        return NSFetchRequest<CoreDataAchievement>(entityName: "CoreDataAchievement")
    }

    @NSManaged public var type: Int16
    @NSManaged public var completionDate: Date

}

extension CoreDataAchievement : Identifiable {

}
