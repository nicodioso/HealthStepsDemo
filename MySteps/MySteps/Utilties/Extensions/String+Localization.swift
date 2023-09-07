//
//  String+Localization.swift
//  MySteps
//
//  Created by Nico Dioso on 8/8/23.
//

import SwiftUI

extension String {
    var localized: String {
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self
        )
    }
    
    /// Adds arguments inside the string provided. This uses `String(format: String, _ arguments: CVarArg...)`.
    func localized(withArguments args: CVarArg...) -> String {
        return String(format: localized, args)
    }
}
