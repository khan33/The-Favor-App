//
//  FavorListView.swift
//  The Favour
//
//  Created by Atta khan on 05/05/2023.
//

import SwiftUI

struct FavorListView: View {
    let favor: FavorList?
    
    var action: (() -> Void)? = nil

    var body: some View {
        FavorInfoView(image: "", name: favor?.category ?? "", favTitle: favor?.title ?? "", rating: String(favor?.avg_rating ?? 0), totalReview: "|  \(favor?.reviews?.count ?? 0) reviews")
            .padding(8)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        )
        .onTapGesture {
            action?()
        }
    }
}
