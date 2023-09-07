//
//  DayStepActivity.swift
//  MySteps
//
//  Created by Nico Dioso on 8/4/23.
//

import Foundation

struct DayStepActivity: Identifiable {
    
    let id = UUID()
    let monthDay: Int
    let stepCount: Int
}
