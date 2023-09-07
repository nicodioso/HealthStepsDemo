//
//  CUIAchievemen+HList.swift
//  MySteps
//
//  Created by Nico Dioso on 8/4/23.
//

import SwiftUI

extension CUIAchievement {
    struct HList: View {
        
        let data: [Achievement]
        let onTap: (Achievement)->()
        
        var body: some View {
            if data.isEmpty {
                VStack(spacing: 0) {
                    Image("no-achievement")
                        .resizable()
                        .frame(width: 94, height: 94)
                        .padding(.bottom, 15)
                    Text("No achievements yet")
                        .font(.system(size: 21, weight: .bold))
                        .padding(.bottom, 4)
                    Text("Take the first step!")
                        .font(.system(size: 21, weight: .medium))
                        .opacity(0.5)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.top, 10)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 24) {
                        ForEach(data) { achievement in
                            Button {
                                onTap(achievement)
                            } label: {
                                CUIAchievement.Item(achievement, config: .list)
                            }
                        }
                    }
                    .padding(.horizontal, 28)
                }
                .padding(.horizontal, -20)
            }
        }
    }
}

struct AchievementHListPreview: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            Color.black
            CUIAchievement.HList(
                data: [
                    AchievementType.thirtyThousandSteps,
                    .twentyFiveThousandSteps,
                    .twentyThousandSteps,
                    .fifteenThousandSteps,
                    .tenThousandSteps
                ].map{ .init(type: $0, completionDate: Date()) }
            ) { tappedAchievement in
               
            }
        }
    }
}
