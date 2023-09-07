//
//  BaseVM.swift
//  MySteps
//
//  Created by Nico Dioso on 8/5/23.
//

import SwiftUI

class BaseVM: ObservableObject {
    
    private var onNavigate: ((any Destination)->())?
    private var onNavigateBack: (()->())?
    var persistence = PersistenceController.shared
    
    var preview: Self {
        let vm = self
        vm.persistence = .preview
        return vm
    }
    
    func initializeRouterNavigations(onNavigate: @escaping (any Destination)->(),  onNavigateBack: @escaping ()->()) {
        self.onNavigate = onNavigate
        self.onNavigateBack = onNavigateBack
    }
    
    func navigate(to destination: any Destination) {
        guard let onNavigate
        else {
            fatalError("`.connectRouter(to viewModel:)` was not implemented in the view")
        }
        onNavigate(destination)
    }
    
    func navigateBack() {
        guard let onNavigateBack
        else {
            fatalError("`.connectRouter(to viewModel:)` was not implemented in the view")
        }
        onNavigateBack()
    }
}


// ViewModel(router: router)
