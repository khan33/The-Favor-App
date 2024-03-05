//
//  FavorServicesView.swift
//  The Favour
//
//  Created by Atta khan on 10/05/2023.
//

import SwiftUI

struct FavorServicesView: View {
    let image: String
    let name: String
    let favTitle: String
    let rating: String
    let totalReview: String
    var service: [String]
    var action: (() -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            FavorInfoView(image: image, name: name, favTitle: favTitle, rating: rating, totalReview: "|  \(totalReview)")
            
            
            HStack {
                FavorText(text: "Location: ", textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)), fontType: .regular, fontSize: 12, alignment: .center, lineSpace: 0)
                FavorText(text: "8 mi away", textColor: .appPrimaryColor, fontType: .bold, fontSize: 14, alignment: .center, lineSpace: 0)
                
                Spacer()
            }
            .padding(.leading, 12)
            
            
            
            FavorText(text: "Plumbing Repair", textColor: .appBlack, fontType: .bold, fontSize: 18, alignment: .leading, lineSpace: 0)
                .padding(.leading, 12)
            

            FavorText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit Ut et massa mi. Lorem ipsum dolor sit ameti......", textColor: .appLightBlack, fontType: .regular, fontSize: 14, alignment: .leading, lineSpace: 0)
                .padding(.leading, 12)

            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<service.count) { index in
                        ServiceButtonView(text: service[index], textColor:.appWhite , bgColor: .appPrimaryColor, cornerRadius: 10)
                    }
                }
            }
            .padding(.leading, 20)
            
            FavorDividerView(width: .infinity, height: 1)
                .padding([.horizontal], 24)
                
            HStack (alignment: .center){
                Spacer()
                Image(systemName: "arrow.forward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .onTapGesture {
                        action?()
                    }
                Spacer()
            }
            
            .padding(.bottom, 16)
                

        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 32)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        )
    }
    
}

struct FavorServicesView_Previews: PreviewProvider {
    static var previews: some View {
        FavorServicesView(image: "fav_cleaning", name: "Kylee Danford", favTitle: "House Cleaning", rating: "4.8", totalReview: "8.889 reviews",service: ["Cleaning", "Repairing", "Painting"])
    }
}
