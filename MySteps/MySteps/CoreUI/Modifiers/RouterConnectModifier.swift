//
//  RouterConnectModifier.swift
//  MySteps
//
//  Created by Nico Dioso on 8/5/23.
//

import SwiftUI

struct RouterConnectModifier: ViewModifier {
    
    @EnvironmentObject private var router: Router
    @ObservedObject var viewModel: BaseVM
    
    func body(content: Content) -> some View {
        content
            .onLoad {
                viewModel.initializeRouterNavigations(onNavigate: router.navigate, onNavigateBack: router.navigateBack)
            }
    }
}

extension View {
    func connectRouter(to viewModel: BaseVM) -> some View {
        self.modifier(RouterConnectModifier(viewModel: viewModel))
    }
}
