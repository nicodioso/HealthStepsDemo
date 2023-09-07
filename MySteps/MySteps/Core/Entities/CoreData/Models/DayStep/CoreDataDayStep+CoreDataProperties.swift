//
//  CoreDataDayStep+CoreDataProperties.swift
//  MySteps
//
//  Created by Nico Dioso on 8/5/23.
//
//

import Foundation
import CoreData


extension CoreDataDayStep {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataDayStep> {
        return NSFetchRequest<CoreDataDayStep>(entityName: "CoreDataDayStep")
    }

    @NSManaged public var month: Int16
    @NSManaged public var year: Int16
    @NSManaged public var date: Date
    @NSManaged public var count: Int64

}

extension CoreDataDayStep : Identifiable {

}
