//
//  CUIAchievement+Item.swift
//  MySteps
//
//  Created by Nico Dioso on 8/4/23.
//

import SwiftUI


extension CUIAchievement {
    struct Item: View {
        
        let achievement: Achievement
        let config: ViewConfig
        
        init(_ achievement: Achievement, config: ViewConfig) {
            self.achievement = achievement
            self.config = config
        }
        
        var body: some View {
            VStack(spacing: config.spacing) {
                Image(achievement.type.imageName)
                    .resizable()
                    .frame(width: config.iconSize.width, height: config.iconSize.height)
                    .mask(Circle())
                Text(achievement.type.name)
                    .font(.system(size: config.titleSize, weight: .bold))
                Text(achievement.completionDate.toString(format: .monthDate))
                    .font(.system(size: config.dateSize, weight: .semibold))
                    .opacity(0.5)
            }
            .foregroundColor(.white)
        }
    }
}

extension CUIAchievement.Item {
    struct ViewConfig {
        
        let spacing: CGFloat
        let titleSize: CGFloat
        let dateSize: CGFloat
        let iconSize: CGSize
        
        static let list = Self(spacing: 6, titleSize: 16, dateSize: 13, iconSize: .init(width: 116, height: 116))
        
        static let fullPage = Self(spacing: 10.7, titleSize: 32, dateSize: 24, iconSize: .init(width: 207, height: 207))
    }
}

struct AchievementItemPreview: PreviewProvider {
    
    static var previews: some View {
        ZStack {
            Color.black
            CUIAchievement.Item(.init(type: .fifteenThousandSteps, completionDate: Date()), config: .fullPage)
                .frame(width: 207)
        }
    }
}
