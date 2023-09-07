//
//  MonthStepData+Util.swift
//  MySteps
//
//  Created by Nico Dioso on 8/8/23.
//

import Foundation

extension MonthStepsData {
    /// Returns the summed up `stepCount` values of `data`
    var totalSteps: Int {
        return data.map{ $0.stepCount }.reduce(0, +)
    }
}
