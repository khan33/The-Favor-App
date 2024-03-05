//
//  FavorInfoView.swift
//  The Favour
//
//  Created by Atta khan on 12/05/2023.
//

import SwiftUI

struct FavorInfoView: View {
    let image: String
    let name: String
    let favTitle: String
    let rating: String
    let totalReview: String
    
    
    var body: some View {
        HStack {
//            Image("fav_cleaning")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 88, height: 88)
//                .padding([.leading, .vertical])
//            AsyncImage(url: URL(string: image)) { image in
//                    image
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 88, height: 88)
//                        .padding([.leading, .vertical])
//                } placeholder: {
//                    Image("fav_cleaning")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 88, height: 88)
//                        .padding([.leading, .vertical])
//
//                }
            VStack(alignment: .leading, spacing: 4) {
                FavorText(text: favTitle, textColor: .appBlack, fontType: .bold, fontSize: 16, alignment: .leading, lineSpace: 0)
                FavorText(text: name, textColor: .appLightGrey, fontType: .regular, fontSize: 10, alignment: .leading, lineSpace: 0)
                    .padding(.bottom, 8)
                HStack {
                    
                    Image("Star")
                    
                    FavorText(text: rating, textColor: Color(#colorLiteral(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)), fontType: .medium, fontSize: 14, alignment: .leading, lineSpace: 0)
                    FavorText(text: "|  \(totalReview)", textColor: Color(#colorLiteral(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)), fontType: .medium, fontSize: 14, alignment: .leading, lineSpace: 0)
                }
                
            }
            .padding()
            Spacer()
        }
    }
}

struct FavorInfoView_Previews: PreviewProvider {
    static var previews: some View {
        FavorInfoView(image: "fav_cleaning", name: "Kylee Danford", favTitle: "House Cleaning", rating: "4.8", totalReview: "8.889 reviews")
        
       
    }
}
