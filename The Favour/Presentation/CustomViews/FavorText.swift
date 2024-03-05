//
//  FavorText.swift
//  The Favour
//
//  Created by Atta khan on 16/04/2023.
//

import SwiftUI

struct FavorText: View {
    let text: String
    var textColor: Color = .appBlack
    var fontType: DefaultFontFamily = .light
    var fontSize: CGFloat = 14
    var alignment: TextAlignment = .leading
    var lineSpace: CGFloat = 1
    
    var body: some View {
        Text(text)
            .foregroundColor(textColor)
            .font(.localizedFont(fontType: fontType, fontSize: fontSize))
            .multilineTextAlignment(alignment)
            .lineSpacing(lineSpace)
    }
}

struct FavorText_Previews: PreviewProvider {
    static var previews: some View {
        FavorText(text: "Favour lable text here..")
    }
}
