//
//  HorizontalTwoLabelView.swift
//  The Favour
//
//  Created by Atta khan on 28/04/2023.
//

import SwiftUI

struct HorizontalTwoLabelView: View {
    var label1: String = ""
    var label2: String = ""
    var textColorLbl1: Color = Color(#colorLiteral(red: 0.38, green: 0.38, blue: 0.38, alpha: 1))
    var fontTypeLbl1: DefaultFontFamily = .regular
    var fontSizeLbl1: CGFloat = 14
    
    var textColorLbl2: Color = Color(#colorLiteral(red: 0.26, green: 0.26, blue: 0.26, alpha: 1))
    var fontTypeLbl2: DefaultFontFamily = .semiBold
    var fontSizeLbl2: CGFloat = 16

    
    var body: some View {
        HStack {
            FavorText(text: label1, textColor: textColorLbl1, fontType: fontTypeLbl1, fontSize: fontSizeLbl1, alignment: .center, lineSpace: 0)
            Spacer()
            FavorText(text: label2, textColor: textColorLbl2, fontType: fontTypeLbl2, fontSize: fontSizeLbl2, alignment: .center, lineSpace: 0)
        }
    }
}

struct HorizontalTwoLabelView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalTwoLabelView(label1: "Withdraw Amount", label2: "$50")
    }
}
