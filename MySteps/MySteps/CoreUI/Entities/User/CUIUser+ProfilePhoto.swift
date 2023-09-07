//
//  CUIUser+ProfilePhoto.swift
//  MySteps
//
//  Created by Nico Dioso on 8/3/23.
//

import SwiftUI

extension CUIUser {
    struct ProfilePhoto: View {
        
        var body: some View {
            Image("profile-photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .mask(Circle())
                .background(
                    GeometryReader { geo in
                        Image("profile-bg-effect")
                            .resizable()
                            .padding(-(geo.size.width*0.5))
                        CUIDecor.VisualEffect(style: .light)
                            .mask { Circle() }
                            .padding(-5)
                    }
                )
        }
    }
}

struct UserProfilePreview: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            CUIUser.ProfilePhoto()
                .padding(40)
        }
    }
}
