//
//  CUIAchievement+Summary.swift
//  MySteps
//
//  Created by Nico Dioso on 8/4/23.
//

import SwiftUI

extension CUIAchievement {
    struct Summary: View {
        
        let count: Int
        
        var body: some View {
            HStack {
                Text("Achievements")
                    .foregroundColor(.white)
                Text("\(count)")
                    .foregroundColor(.appBlue)
            }
            .font(.system(size: 24, weight: .bold))
        }
    }
}
