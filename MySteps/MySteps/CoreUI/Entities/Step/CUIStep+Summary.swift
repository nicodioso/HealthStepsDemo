//
//  CUIStep+Summary.swift
//  MySteps
//
//  Created by Nico Dioso on 8/4/23.
//

import SwiftUI

extension CUIStep {
    struct Summary: View {
        
        let date: Date
        let total: Int
        
        var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Steps")
                        .font(.system(size: 32, weight: .black))
                        .foregroundColor(.white)
                    Text(date.toString(format: .monthYear))
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                        .opacity(0.5)
                }
                Spacer()
                Text(total.formatted())
                    .foregroundColor(.appGreen)
                    .font(.system(size: 32))
            }
        }
    }
}
