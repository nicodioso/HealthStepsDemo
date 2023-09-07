//
//  Router.swift
//  MySteps
//
//  Created by Nico Dioso on 8/5/23.
//

import SwiftUI

class Router: ObservableObject {
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: any Destination) {
        withAnimation {
            navPath.append(destination)
        }
    }
    
    func navigateBack() {
        withAnimation {
            navPath.removeLast()
        }
    }
}
