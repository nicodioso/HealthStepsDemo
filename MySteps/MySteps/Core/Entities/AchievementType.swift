//
//  Achievement.swift
//  MySteps
//
//  Created by Nico Dioso on 8/4/23.
//

import Foundation

enum AchievementType: Int, CaseIterable {
    
    case tenThousandSteps
    case fifteenThousandSteps
    case twentyThousandSteps
    case twentyFiveThousandSteps
    case thirtyThousandSteps
    case thirtyFiveThousandSteps
    case fortyThousandSteps
    
    var imageName: String {
        switch self {
        case .tenThousandSteps:
            return "achievement-10k"
        case .fifteenThousandSteps:
            return "achievement-15k"
        case .twentyThousandSteps:
            return "achievement-20k"
        case .twentyFiveThousandSteps:
            return "achievement-25k"
        case .thirtyThousandSteps:
            return "achievement-30k"
        case .thirtyFiveThousandSteps:
            return "achievement-35k"
        case .fortyThousandSteps:
            return "achievement-40k"
        }
    }
    
    var name: String {
        var name = ""
        switch self {
        case .tenThousandSteps:
            name += "10k"
        case .fifteenThousandSteps:
            name += "15k"
        case .twentyThousandSteps:
            name += "20k"
        case .twentyFiveThousandSteps:
            name += "25k"
        case .thirtyThousandSteps:
            name += "30k"
        case .thirtyFiveThousandSteps:
            name += "35k"
        case .fortyThousandSteps:
            name += "40k"
        }
        return "%@ Steps".localized(withArguments: name)
    }
    
    var stepCount: Int {
        switch self {
        case .tenThousandSteps:
            return 10000
        case .fifteenThousandSteps:
            return 15000
        case .twentyThousandSteps:
            return 20000
        case .twentyFiveThousandSteps:
            return 25000
        case .thirtyThousandSteps:
            return 30000
        case .thirtyFiveThousandSteps:
            return 35000
        case .fortyThousandSteps:
            return 40000
        }
    }
    
    var id: Int { rawValue }
}
