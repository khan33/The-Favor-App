//
//  NeedFavorCellView.swift
//  The Favour
//
//  Created by Atta khan on 17/05/2023.
//

import SwiftUI

struct NeedFavorCellView: View {
    var bookingFavor: BookingData?
    var action: (() -> Void)? = nil

    var body: some View {
        VStack(alignment: .leading) {
            FavorInfoView(image: "fav_cleaning", name: bookingFavor?.favor_details?.category ?? "", favTitle: bookingFavor?.favor_details?.title ?? "", rating: bookingFavor?.review?.rating ?? "", totalReview: "|  45")
            
            VStack(alignment: .leading, spacing: 10) {
                FavorText(text: bookingFavor?.details ?? "", textColor: .appLightBlack, fontType: .regular, fontSize: 14, alignment: .leading, lineSpace: 0)
                
                
                FavorButton(text: UtilityManager.shared.buttonText(for: bookingFavor?.status ?? .pending), width: .infinity, height: 50, textColor: UtilityManager.shared.buttonColor(for: bookingFavor?.status ?? .pending), bgColor: .appWhite) {
                }
                .disabled(true)
                .border(UtilityManager.shared.buttonColor(for: bookingFavor?.status ?? .pending), width: 0.5, cornerRadius: 24)
            }
            .padding([.horizontal, .bottom], 16)
        }
        .background(
            Color.white.cornerRadius(16)
        )
        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)

        .onTapGesture {
            action?()
        }
    }
}

struct NeedFavorCellView_Previews: PreviewProvider {
    static var previews: some View {
        NeedFavorCellView()
    }
}
