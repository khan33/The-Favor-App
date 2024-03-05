//
//  FavorSpinnerView.swift
//  The Favour
//
//  Created by Atta khan on 26/06/2023.
//

import SwiftUI

struct FavorSpinnerView: ViewModifier {
    
    @Binding var isShowing: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isShowing {
                Rectangle()
                    .foregroundColor(.appWhite)
                    .opacity(0.65)
                Circle()
                    .foregroundColor(.appPrimaryColor)
                    .frame(width: 50, height: 50)
                    .offset(y: -80)
                ProgressView()
                    .tint(.appWhite)
                    .foregroundColor(.appWhite)
                    .progressViewStyle(.circular)
                    .offset(y: -80)
            }
        }
    }
}

