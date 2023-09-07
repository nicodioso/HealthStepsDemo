//
//  Sequence+Async.swift
//  MySteps
//
//  Created by Nico Dioso on 8/5/23.
//

import Foundation

extension Sequence {
    /// Performs a foreach loop asychronously
    func asyncForEach(
        _ operation: (Element) async throws -> Void
    ) async rethrows {
        for element in self {
            try await operation(element)
        }
    }
}
