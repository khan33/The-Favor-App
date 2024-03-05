//
//  SocialIconView.swift
//  The Favour
//
//  Created by Atta khan on 16/04/2023.
//

import SwiftUI

struct SocialIconView: View {
    let imageName: String
    var action: (() -> Void)?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.white)
                .frame(width: 98, height: 60)
                .border(.appBorderColor, width: 1, cornerRadius: 12)

            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
        }
        .onTapGesture {
            action?()
        }
    }
}

struct SocialIconView_Previews: PreviewProvider {
    static var previews: some View {
        SocialIconView(imageName: "fb")
    }
}
