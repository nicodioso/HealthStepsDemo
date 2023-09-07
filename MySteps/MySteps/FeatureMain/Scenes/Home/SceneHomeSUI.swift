//
//  SceneHomeSUI.swift
//  MySteps
//
//  Created by Nico Dioso on 8/3/23.
//

import SwiftUI
import CoreData

struct SceneHomeSUI: View {
    
    @StateObject var viewModel = ViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                CUIUser.ProfilePhoto()
                    .frame(width: 180, height: 180)
                    .padding(.top, 57.6)
                    .padding(.bottom, 21.5)
                CUIStep.Summary(
                    date: viewModel.monthStepData.monthDate,
                    total: viewModel.monthStepData.totalSteps
                ).padding(.bottom, 7)
                CUIStep.Graph(monthData: viewModel.monthStepData)
                    .padding(.bottom, 44)
                    .padding(.horizontal, -24)
                VStack(alignment: .leading, spacing: 18) {
                    CUIAchievement.Summary(count: viewModel.achievements.count)
                    CUIAchievement.HList(data: viewModel.achievements) { tappedAchievement in
                        viewModel.handleTap(of: tappedAchievement)
                    }
                }
            }
            .padding(.horizontal, 24)
        }
        .background(Color.black)
        .navigationDestination(for: HomeDestination.self) { destination in
            switch destination {
            case .achievement(let data):
                SceneAchievementSUI(achievement: data)
            }
        }
        .errorAlert($viewModel.error)
        .connectRouter(to: viewModel)
        .onLoad {
            viewModel.setupHealthKit()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SceneHomeSUI(viewModel: .init().preview)
            .environmentObject(Router())
    }
}
