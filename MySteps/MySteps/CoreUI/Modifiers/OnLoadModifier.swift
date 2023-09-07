//
//  OnLoadModifier.swift
//  MySteps
//
//  Created by Nico Dioso on 8/5/23.
//

import SwiftUI

fileprivate struct OnLoadModifier: ViewModifier {

    @State private var hasLoaded = false
    private let action: (() -> Void)?

    init(perform action: (() -> Void)? = nil) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            if !hasLoaded {
                hasLoaded = true
                action?()
            }
        }
    }

}

extension View {
    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(OnLoadModifier(perform: action))
    }
}
