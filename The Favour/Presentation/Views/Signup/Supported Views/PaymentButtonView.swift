//
//  PaymentButtonView.swift
//  The Favour
//
//  Created by Atta khan on 26/04/2023.
//

import SwiftUI

struct PaymentButtonView: View {
    let image: String
    let method: String
    let status: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.white)
                .shadow(color: Color.appLightGrey, radius: 10, x: 1, y: 1)
                .frame(width: .infinity, height: 88)
            
            HStack {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44)
                    .padding(.leading, 24)
                    .padding(.trailing, 8)
                FavorText(text: method, textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)), fontType: .bold, fontSize: 18)
                Spacer()
                
                FavorText(text: status, textColor: .appPrimaryColor, fontType: .bold, fontSize: 18)
                    .padding(.trailing, 24)
      
                
            }
        }
    }
}

struct PaymentButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentButtonView(image: "google", method: "Google Pay", status: "Not Connected")
    }
}
