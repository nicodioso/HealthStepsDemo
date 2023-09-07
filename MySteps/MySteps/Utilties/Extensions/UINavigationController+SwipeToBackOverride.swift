//
//  UINavigationController+SwipeToBackOverride.swift
//  MySteps
//
//  Created by Nico Dioso on 8/4/23.
//

import UIKit

// Calling `.navigationBarBackButtonHidden(true)` disables Swipe to back gestures of that Navigation page. This reenables the said gesture.
extension UINavigationController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
