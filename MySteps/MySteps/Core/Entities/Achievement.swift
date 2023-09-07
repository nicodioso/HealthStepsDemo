//
//  Achievement.swift
//  MySteps
//
//  Created by Nico Dioso on 8/4/23.
//

import Foundation

struct Achievement: Identifiable, Hashable {
    
    let id = UUID()
    let type: AchievementType
    let completionDate: Date
}
