//
//  BottomButtonView.swift
//  The Favour
//
//  Created by Atta khan on 16/05/2023.
//

import SwiftUI

struct BottomButtonView: View {
    
    var body: some View {
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
}

struct BottomButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BottomButtonView()
    }
}
