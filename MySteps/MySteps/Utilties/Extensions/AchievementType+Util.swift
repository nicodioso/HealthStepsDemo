//
//  AchievementType+Util.swift
//  MySteps
//
//  Created by Nico Dioso on 8/8/23.
//

import Foundation

extension Array where Element == AchievementType {
    /// Returns the all achievements available with the **stepCount** provided
    mutating func removeAchievements(forStepCount stepCount: Int) -> Self {
        var removed: [AchievementType] = []
        var retained: [AchievementType] = []
        forEach { achievement in
            if achievement.stepCount <= stepCount {
                removed.append(achievement)
            } else {
                retained.append(achievement)
            }
        }
        self = retained
        return removed
    }
}
