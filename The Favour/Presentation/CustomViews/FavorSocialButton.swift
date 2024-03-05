//
//  FavorSocialButton.swift
//  The Favour
//
//  Created by Atta khan on 16/04/2023.
//

import SwiftUI

struct FavorSocialButton: View {
    let text: String
    let image: String?
    let width: CGFloat
    let height: CGFloat
    let fontType: DefaultFontFamily
    let fontSize: CGFloat
    let action: (() -> Void)?
    var body: some View {
        button
            .frame(width: width, height: height, alignment: .center)

    }
    private var button: some View {
        Button {
            action?()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: height / 2)
                    .frame(width: width, height: height)
                    .foregroundColor(.appWhite)
                    .border(.appBorderColor, width: 1, cornerRadius: 16)
                
                HStack() {
                    if let image = image {
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                    }
                    Text(text)
                        .font(.localizedFont(fontType: fontType, fontSize: fontSize))
                        .foregroundColor(.appBlack)
                }
                .foregroundColor(.appWhite)
            }
        }
    }
}

struct FavorSocialButton_Previews: PreviewProvider {
    static var previews: some View {
        FavorSocialButton(text: "Login with facebook", image: "fb", width: UIScreen.screenWidth - 48, height: 66, fontType: .light, fontSize: 14, action: nil)
    }
}
