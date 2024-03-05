//
//  PriceQuoteView.swift
//  The Favour
//
//  Created by Atta khan on 17/05/2023.
//

import SwiftUI

struct PriceQuoteView: View {
    
    var gradientColor: Gradient = Gradient(stops: [
        .init(color: Color(#colorLiteral(red: 0.4470588235, green: 0.06274509804, blue: 1, alpha: 1)), location: 0),
        .init(color: Color(#colorLiteral(red: 0.6156862745, green: 0.3490196078, blue: 1, alpha: 1)), location: 1)])
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(LinearGradient(
                    gradient: gradientColor,
                    startPoint: UnitPoint(x: 1.0000000298023233, y: 1.000000029802323),
                    endPoint: UnitPoint(x: 1.1102230246251565e-16, y: -4.440892098500626e-16)))
                .frame(width: .infinity, height: 240)
                .shadow(color: Color(#colorLiteral(red: 0.01568627543747425, green: 0.0235294122248888, blue: 0.05882352963089943, alpha: 0.05000000074505806)), radius:60, x:0, y:4)
            
            VStack (alignment: .leading, spacing: 8) {
                HStack {
                    VStack(alignment: .leading) {
                        
                        FavorText(text: "Price Quoted", textColor:  .appLightGrey, fontType: .bold, fontSize: 16, alignment: .leading, lineSpace: 0)
                        
                        FavorText(text: "$50", textColor:  .appWhite, fontType: .bold, fontSize: 32, alignment: .leading, lineSpace: 0)
                        
                    }

                    Spacer()
                    Image("award")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 40)
                        .padding(.trailing, 24)
                    
                }
                
                
                FavorText(text: "My Detail", textColor:  .appLightGrey, fontType: .bold, fontSize: 16, alignment: .leading, lineSpace: 0)
                FavorText(text: "I need a handyman service for my home to fix my kitchen", textColor:  .appWhite, fontType: .bold, fontSize: 16, alignment: .leading, lineSpace: 0)
                
                FavorText(text: "Date & Time", textColor:  .appLightGrey, fontType: .bold, fontSize: 16, alignment: .leading, lineSpace: 0)
                FavorText(text: "Dec 23, 2024 | 10:00 - 12:00 AM", textColor:  .appWhite, fontType: .bold, fontSize: 16, alignment: .leading, lineSpace: 0)
                
                
            }
            .padding(.leading, 24)

            
            
        }
        .padding(.horizontal, 16)

    }
}

struct PriceQuoteView_Previews: PreviewProvider {
    static var previews: some View {
        PriceQuoteView()
    }
}
