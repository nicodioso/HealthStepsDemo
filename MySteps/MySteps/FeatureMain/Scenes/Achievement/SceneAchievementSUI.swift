//
//  SceneAchievementSUI.swift
//  MySteps
//
//  Created by Nico Dioso on 8/4/23.
//

import SwiftUI

struct SceneAchievementSUI: View {
    
    let achievement: Achievement
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            CUIAchievement.Item(achievement, config: .fullPage)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Achievement")
                    .foregroundColor(.white)
                    .font(.system(size: 24, weight: .black))
            }
            ToolbarItem(placement: .navigationBarLeading) {
                CUINavigation.BackButton()
            }
        }
    }
}
