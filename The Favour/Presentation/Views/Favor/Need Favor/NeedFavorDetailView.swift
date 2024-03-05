//
//  NeedFavorDetailView.swift
//  The Favour
//
//  Created by Atta khan on 17/05/2023.
//

import SwiftUI

struct NeedFavorDetailView: View {
    var body: some View {
        VStack(alignment: .leading) {
            VStack(spacing: 16) {
                NavigationBarView(text: "Detail")
                
                ScrollView (showsIndicators: false) {
                    favorHeaderInfo
                    FavorDividerView(width: .infinity, height: 0.5)
                    
                    PriceQuoteView()
                    PriceQuoteView(gradientColor: Gradient(stops: [
                        .init(color: Color(#colorLiteral(red: 0.1333333333, green: 0.7333333333, blue: 0.6117647059, alpha: 1)), location: 0),
                        .init(color: Color(#colorLiteral(red: 0.2078431373, green: 0.8705882353, blue: 0.737254902, alpha: 1)), location: 1)])
                                   )
                    
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: Color(#colorLiteral(red: 0.1333333333, green: 0.7333333333, blue: 0.6117647059, alpha: 1)), location: 0),
                                    .init(color: Color(#colorLiteral(red: 0.2078431373, green: 0.8705882353, blue: 0.737254902, alpha: 1)), location: 1)]),
                                startPoint: UnitPoint(x: 1.0000000298023233, y: 1.000000029802323),
                                endPoint: UnitPoint(x: 1.1102230246251565e-16, y: -4.440892098500626e-16)))
                            .frame(width: 380, height: 90)
                            .shadow(color: Color(#colorLiteral(red: 0.01568627543747425, green: 0.0235294122248888, blue: 0.05882352963089943, alpha: 0.05000000074505806)), radius:60, x:0, y:4)
                        
                        HStack {
                            FavorText(text: "User has started the favor please click on start to proceed.", textColor:  .appWhite, fontType: .bold, fontSize: 16, alignment: .leading, lineSpace: 0)
                            
                            Spacer()
                            Image(systemName: "info.circle")
                                .foregroundColor(.appWhite)
                        }
                        .padding()
                    }
                    .padding(.horizontal, 16)
                    
                }
            }
            .padding([.horizontal, .top], 24)
            .padding(.bottom, 0)
        }
        .navigationBarHidden(true)
        .navigationTitle("")
        .edgesIgnoringSafeArea(.bottom)
    }
}

extension NeedFavorDetailView {
    @ViewBuilder private var favorHeaderInfo: some View {
        FavorInfoView(image: "fav_cleaning", name: "Kylee Danford", favTitle: "Cleaning", rating: "4.8", totalReview: "| 8.889")
        
        HStack {
            FavorButton(text: "Cleaning", width: 68, height: 24, textColor: .appPrimaryColor, fontType: .regular, fontSize: 10,  bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
            }
            AddressView(address: "255 Grand Park Avenue, New York" )
        }
    }
}

struct NeedFavorDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NeedFavorDetailView()
    }
}
