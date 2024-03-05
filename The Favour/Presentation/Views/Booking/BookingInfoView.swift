//
//  BookingInfoView.swift
//  The Favour
//
//  Created by Atta khan on 16/05/2023.
//

import SwiftUI

struct BookingInfoView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 8) {
                Image("user_profile")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 56, height: 56)
                    
                VStack(alignment: .leading, spacing: 4) {
                    FavorText(text: "Jenny Wilson", textColor: .appWhite, fontType: .bold, fontSize: 18, alignment: .center, lineSpace: 0)
                    FavorText(text: "16 $", textColor: .appWhite, fontType: .bold, fontSize: 24, alignment: .center, lineSpace: 0)

                }
                .padding(12)
                Spacer()
            }
            
            HorizontalTwoLabelView(label1: "Date & Time", label2: "Dec 12, 2024 | 13:00 - 15:00 PM", textColorLbl1 : .appWhite, fontTypeLbl1: .medium, fontSizeLbl1: 14, textColorLbl2: .appWhite, fontTypeLbl2: .semiBold, fontSizeLbl2: 16)
            HorizontalTwoLabelView(label1: "Location", label2: "1691 Carpenter Pass", textColorLbl1 : .appWhite, fontTypeLbl1: .medium, fontSizeLbl1: 14, textColorLbl2: .appWhite, fontTypeLbl2: .semiBold, fontSizeLbl2: 16)
            Spacer()
            
        }
        .padding()
        .background(
            LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: Color(#colorLiteral(red: 0.1333333333, green: 0.7333333333, blue: 0.6117647059, alpha: 1)), location: 0),
                            .init(color: Color(#colorLiteral(red: 0.2078431373, green: 0.8705882353, blue: 0.737254902, alpha: 1)), location: 1)]),
                        startPoint: UnitPoint(x: 1.0000000298023233, y: 1.000000029802323),
                        endPoint: UnitPoint(x: 1.1102230246251565e-16, y: -4.440892098500626e-16))
        )
    }
}

struct BookingInfoView_Previews: PreviewProvider {
    static var previews: some View {
        BookingInfoView()
    }
}
