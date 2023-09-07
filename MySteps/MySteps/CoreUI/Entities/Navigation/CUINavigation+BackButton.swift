//
//  CUINavigation+BackButton.swift
//  MySteps
//
//  Created by Nico Dioso on 8/4/23.
//

import SwiftUI

extension CUINavigation {
    struct BackButton: View {
        
        @Environment(\.presentationMode) var presentationMode
        
        var body: some View {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image("back-button")
                    .foregroundColor(.white.opacity(0.5))
            }
        }
    }
}
