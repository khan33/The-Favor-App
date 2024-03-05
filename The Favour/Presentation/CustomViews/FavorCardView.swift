//
//  FavorCardView.swift
//  The Favour
//
//  Created by Atta khan on 26/04/2023.
//

import SwiftUI

struct FavorCardView: View {
    let title: String
    let subTitle: String
    let imageName: String
    let gradientColor: Gradient
    var action: (()-> Void)?
    var body: some View {
        //Elements/Promo & Discount
        ZStack {
            Image("fav_bg_1")
                .resizable()
                .scaledToFit()
            HStack {
                VStack (alignment: .leading, spacing: 8) {
                    FavorText(text: title, textColor: .appWhite, fontType: .bold, fontSize: 22)
                    FavorText(text: subTitle, textColor: .appWhite, fontType: .regular, fontSize: 14)
                }
                .padding()
                .frame(maxHeight: 205, alignment: .top)
                Image(imageName)
                    .resizable()
                    .frame(height: 205, alignment: .trailing)
            }
        }
        .onTapGesture {
            action?()
        }
        .background (
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(
                    gradient: gradientColor,
                    startPoint: UnitPoint(x: 1.0000000298023233, y: 1.000000029802323),
                    endPoint: UnitPoint(x: 1.1102230246251565e-16, y: -4.440892098500626e-16)))
                .shadow(color: Color(#colorLiteral(red: 0.01568627543747425, green: 0.0235294122248888, blue: 0.05882352963089943, alpha: 0.05000000074505806)), radius:60, x:0, y:0)
        )
    }
}
