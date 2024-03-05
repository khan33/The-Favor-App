//
//  RatingView.swift
//  The Favour
//
//  Created by Atta khan on 12/05/2023.
//

import SwiftUI

struct RatingView: View {
    var review: Reviews?
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 16) {
                Image("user_profile")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                
                FavorText(text: review?.created_by_name ?? "", textColor: .appBlack, fontType: .bold, fontSize: 16, alignment: .leading, lineSpace: 0)
                
               
                
                Spacer()
                RatingStarButtonView(text: review?.rating ?? "0", textColor: .appPrimaryColor, fontType: .semiBold, fontSize: 16, bgColor: .white)
            }
            FavorText(text: review?.comments ?? "", textColor: .appBlack, fontType: .regular, fontSize: 14, alignment: .leading, lineSpace: 0)
            if let dateTime = review?.created_at {
                FavorText(text: UtilityManager.shared.getTimeAgoString(from: dateTime), textColor: .appLightBlack, fontType: .medium, fontSize: 12, alignment: .leading, lineSpace: 0)
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView()
    }
}
