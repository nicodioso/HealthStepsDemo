//
//  Date+Util.swift
//  MySteps
//
//  Created by Nico Dioso on 8/4/23.
//

import Foundation

extension Date {
    
    func toString(format: CustomFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.formatString
        return formatter.string(from: self)
    }
    
    enum CustomFormat {
        
        case custom(String)
        /// e.g. January 2023
        case monthYear
        /// e.g. Jan 2023
        case monthDate
        
        var formatString: String {
            switch self {
            case .custom(let string):
                return string
            case .monthYear:
                return "MMMM yyyy"
            case .monthDate:
                return "MMM d"
            }
        }
    }
}
