//
//  VerticalTwoLabelView.swift
//  The Favour
//
//  Created by Atta khan on 17/05/2023.
//

import SwiftUI

struct VerticalTwoLabelView: View {
    var label1: String = ""
    var label2: String = ""
    var textColorLbl1: Color = Color(#colorLiteral(red: 0.38, green: 0.38, blue: 0.38, alpha: 1))
    var fontTypeLbl1: DefaultFontFamily = .regular
    var fontSizeLbl1: CGFloat = 14
    
    var textColorLbl2: Color = Color(#colorLiteral(red: 0.26, green: 0.26, blue: 0.26, alpha: 1))
    var fontTypeLbl2: DefaultFontFamily = .semiBold
    var fontSizeLbl2: CGFloat = 16
    var alignment: HorizontalAlignment = .leading
    
    var body: some View {
        VStack(alignment: alignment) {
            FavorText(text: label1, textColor: textColorLbl1, fontType: fontTypeLbl1, fontSize: fontSizeLbl1, alignment: .center, lineSpace: 0)
            FavorText(text: label2, textColor: textColorLbl2, fontType: fontTypeLbl2, fontSize: fontSizeLbl2, alignment: .center, lineSpace: 0)
            Spacer()
        }
    }
}

struct VerticalTwoLabelView_Previews: PreviewProvider {
    static var previews: some View {
        VerticalTwoLabelView(label1: "Withdraw Amount", label2: "$50")
    }
}
