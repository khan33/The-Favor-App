//
//  FavorDividerView.swift
//  The Favour
//
//  Created by Atta khan on 16/04/2023.
//

import SwiftUI

struct FavorDividerView: View {
        let width: CGFloat
        let height: CGFloat
        var bgColor: Color = .appIconBackground
        
        var body: some View {
            Rectangle()
                .foregroundColor(bgColor)
                .frame(width: width, height: height)
                .padding(.vertical, 8)
        }
    
}

struct FavorDividerView_Previews: PreviewProvider {
    static var previews: some View {
        FavorDividerView(width: .infinity, height: 1, bgColor: .appBorderColor)
    }
}
