//
//  E-ReceiptView.swift
//  The Favour
//
//  Created by Atta khan on 28/04/2023.
//

import SwiftUI

struct E_ReceiptView: View {
    var body: some View {
        VStack (alignment: .center) {
            Image("cong")
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 180)
                .padding(30)
            
            FavorText(text: "Withdraw Successfull", textColor: Color(#colorLiteral(red: 0.65, green: 0.29, blue: 1, alpha: 1)), fontType: .bold, fontSize: 24, alignment: .center, lineSpace: 0)
            
            FavorText(text: "Your money has been transferred successfully", textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)), fontType: .regular, fontSize: 16, alignment: .center, lineSpace: 0)
            
            
            paymentInfo
                .padding(.all)
           
            FavorButton(text: "Done", width: .infinity, height: 60, bgColor: .appPrimaryColor) {

            }
            .padding(.all)
            FavorButton(text: "Share", width: .infinity, height: 60, textColor: .appPrimaryColor, bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
            }
            .padding(.horizontal)
            
            
        }
    }
    
    
    private var paymentInfo: some View {
        VStack(spacing: 20) {
            HorizontalTwoLabelView(label1: "Withdraw Amount", label2: "$50")
            .padding([.top,.horizontal])
            HorizontalTwoLabelView(label1: "No. Ref", label2: "11288889058722")
            .padding([.horizontal])
            HorizontalTwoLabelView(label1: "Date & Time", label2: "Dec 23, 2024 | 10:00 AM")
                .padding([.horizontal, .bottom])
        
        }
        .cornerRadius(20)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                           
        }
    }
}

struct E_ReceiptView_Previews: PreviewProvider {
    static var previews: some View {
        E_ReceiptView()
    }
}
