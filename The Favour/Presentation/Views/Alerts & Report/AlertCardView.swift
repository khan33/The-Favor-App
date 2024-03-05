//
//  AlertCardView.swift
//  The Favour
//
//  Created by Atta khan on 28/04/2023.
//

import SwiftUI

struct AlertCardView: View {
    let image: String
    let timeStr: String
    let title: String
    let desc: String
    var body: some View {
        HStack(alignment: .top) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 88, height: 88)
                .padding([.leading, .vertical])
                VStack(alignment: .leading, spacing: 4) {
                    FavorText(text: title, textColor: image != "favor_reject" ? Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)) : Color(#colorLiteral(red: 0.87, green: 0.07, blue: 0.07, alpha: 1)), fontType: .bold, fontSize: 16, alignment: .center, lineSpace: 0)
                    FavorText(text: timeStr, textColor: .appLightGrey, fontType: .regular, fontSize: 10, alignment: .center, lineSpace: 0)
                        .padding(.bottom, 8)
                    FavorText(text: desc, textColor: Color(#colorLiteral(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)), fontType: .medium, fontSize: 14, alignment: .leading, lineSpace: 0)
                    
                }
                .padding()
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        )
    }
}

struct AlertCardView_Previews: PreviewProvider {
    static var previews: some View {
        AlertCardView(image: "favor_accept", timeStr: "3 min ago", title: "Alex Accepted Your Favor", desc: "Lorem ipsum dolor sit amet, consect.....")
    }
}
