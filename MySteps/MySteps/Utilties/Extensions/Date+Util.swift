//
//  Date+Util.swift
//  MySteps
//
//  Created by Nico Dioso on 8/4/23.
//

import Foundation

extension Date {
    
    var firstDayOfTheMonth: Date {
        let components = Calendar.current.dateComponents([.month, .year], from: self)
        return Calendar.current.date(from: components) ?? self // very unlikely that this will return nil
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
}
