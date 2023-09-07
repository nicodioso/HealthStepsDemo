//
//  MyStepsApp.swift
//  MySteps
//
//  Created by Nico Dioso on 8/3/23.
//

import SwiftUI

@main
struct MyStepsApp: App {
    
    @ObservedObject var router = Router()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                SceneHomeSUI()
                    .environmentObject(router)
            }
            .preferredColorScheme(.dark)
        }
    }
}
