//
//  CUIDecor+VisualEffect.swift
//  MySteps
//
//  Created by Nico Dioso on 8/4/23.
//

import SwiftUI


extension CUIDecor {
    struct VisualEffect: UIViewRepresentable {
        
        @State var style : UIBlurEffect.Style // 1
        
        func makeUIView(context: Context) -> UIVisualEffectView {
            return UIVisualEffectView(effect: UIBlurEffect(style: style)) // 2
        }
        
        func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        } // 3
    }
}
