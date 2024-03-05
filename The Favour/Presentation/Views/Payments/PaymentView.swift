//
//  PaymentView.swift
//  The Favour
//
//  Created by Atta khan on 28/04/2023.
//

import SwiftUI

struct PaymentView: View {
    var body: some View {
        VStack(alignment: .center) {

            paymentInfo
            PaymentButtonView(image: "google", method: "Google Pay", status: "Not Connected")
            
            PaymentButtonView(image: "apple", method: "Apple Pay", status: " Connected")
            
            PaymentButtonView(image: "mastercard", method: "Add Card", status: "Not Connected")
            Spacer()
        }
        .padding(.top, 24)
    }
    
    private var paymentInfo: some View {
        VStack(spacing: 8) {
            FavorText(text: "$50.00", textColor: Color(#colorLiteral(red: 0.65, green: 0.29, blue: 1, alpha: 1)), fontType: .bold, fontSize: 40, alignment: .center, lineSpace: 0)
                .padding(.bottom, 12)
            
            FavorText(text: "Available Balance", textColor: Color(#colorLiteral(red: 0.26, green: 0.26, blue: 0.26, alpha: 1)), fontType: .bold, fontSize: 18, alignment: .center, lineSpace: 0)
            HStack {
                FavorText(text: "Minimum withdraw is", textColor: Color(#colorLiteral(red: 0.26, green: 0.26, blue: 0.26, alpha: 1)), fontType: .regular, fontSize: 14, alignment: .center, lineSpace: 0)
                FavorText(text: "$50", textColor: Color(#colorLiteral(red: 0.26, green: 0.26, blue: 0.26, alpha: 1)), fontType: .regular, fontSize: 14, alignment: .center, lineSpace: 0)
            }
            .padding(.bottom, 8)
            FavorButton(text: "Withdraw",  width: 134, height: 34, bgColor: .appPrimaryColor) {
            }
        }
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView()
    }
}
