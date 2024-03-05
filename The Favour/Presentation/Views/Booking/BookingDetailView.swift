//
//  BookingDetailView.swift
//  The Favour
//
//  Created by Atta khan on 16/05/2023.
//

import SwiftUI

struct BookingDetailView: View {
    var body: some View {
        VStack () {
            VStack(spacing: 16) {
                NavigationBarView(text: "My Booking Detail")
                
                HStack(spacing: 8) {
                    FavorText(text: "I can do a car wash for you at your door step quickly. ", textColor: Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)), fontType: .bold, fontSize: 20, alignment: .leading, lineSpace: 0)
                    
                    Image("more")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                .padding(.top, 20)
                HStack {
                    FavorButton(text: "Cleaning", width: 68, height: 24, textColor: .appPrimaryColor, fontType: .regular, fontSize: 10,  bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
                    }
                    AddressView(address: "255 Grand Park Avenue, New York" )
                }
                FavorDividerView(width: .infinity, height: 0.5)
                BookingInfoView()
                
                Spacer()
            }
            .padding([.horizontal, .top], 24)
            .padding(.bottom, 0)

            
            
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                    .frame(height: 110)

                Rectangle()
                    .frame(height: 110)
                    .foregroundColor(.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.appBorderColor, lineWidth: 1)
                            
                    )
                HStack {
                    FavorButton(text: "Message", width: .infinity, height: 55, textColor: .appPrimaryColor, bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
                    }
                    FavorButton(text: "Book Favor", width: .infinity, height: 55, bgColor: .appPrimaryColor) {
                        
                    }
                }
                .padding(.horizontal, 24)
            }
        }
        .navigationBarHidden(true)
        .navigationTitle("")
        .edgesIgnoringSafeArea(.bottom)

    }
}

struct BookingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookingDetailView()
    }
}
