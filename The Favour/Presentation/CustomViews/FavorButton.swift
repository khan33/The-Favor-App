//
//  FavorButton.swift
//  The Favour
//
//  Created by Atta khan on 16/04/2023.
//

import SwiftUI

struct FavorButton: View {
    let text: String?
    var image: String? = nil
    let width: CGFloat
    var height: CGFloat = 48
    var textColor: Color = .appWhite
    var fontType: DefaultFontFamily = .bold
    var fontSize: CGFloat = 14
    var bgColor: Color = .appPrimaryColor
    var disabled: Bool = false

    var action: (() -> Void)? = nil
    var body: some View {
        button
            .frame(width: width, height: height, alignment: .center)

    }
    var buttonBgColor: Color {
        return disabled ? .appLightGrey : .appBlack
    }
    private var button: some View {
        Button {
            action?()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: height / 2)
                    .frame(width: width, height: height)
                    .foregroundColor(bgColor)
                    .shadow(color: bgColor, radius: 1, x: 1, y: 3)
                
                HStack {
                    if let text = text {
                        Text(text)
                            .font(.localizedFont(fontType: fontType, fontSize: fontSize))
                    }
                    
                    if let image = image {
                        Image(image)
                            .resizable()
                            .frame(width: 18, height: 18)
                            .scaledToFit()
                            .flipsForRightToLeftLayoutDirection(true)
                    }
                    
                }
                .foregroundColor(textColor)
            }
        }
        .disabled(disabled ? true : false)
    }
}

struct FavorButton_Previews: PreviewProvider {
    static var previews: some View {
        FavorButton(text: "Login", width: 200)
    }
}
