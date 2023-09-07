//
//  AlertErrorModifier.swift
//  MySteps
//
//  Created by Nico Dioso on 8/5/23.
//

import SwiftUI

fileprivate struct AlertErrorModifier: ViewModifier {
    
    @Binding var error: LocalizedError?
    
    func body(content: Content) -> some View {
        content
            .alert(error?.errorDescription ?? "Oh no!".localized(), isPresented: .constant(error != nil), presenting: error) { _ in
                Button("Okay".localized()) {
                    error = nil
                }
            } message: { error in
                Text(error.recoverySuggestion ?? "Something went wrong.")
            }
    }
}

extension View {
    func errorAlert(_ error: Binding<LocalizedError?>) -> some View {
        modifier(AlertErrorModifier(error: error))
    }
}
