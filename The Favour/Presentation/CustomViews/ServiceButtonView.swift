//
//  ServiceButtonView.swift
//  The Favour
//
//  Created by Atta khan on 05/05/2023.
//

import SwiftUI

struct ServiceButtonView: View {
    let text: String?
    var textColor: Color = .appWhite
    var fontType: DefaultFontFamily = .bold
    var fontSize: CGFloat = 12
    var bgColor: Color = .appPrimaryColor
    var cornerRadius: CGFloat = 16
    var action: (() -> Void)? = nil
    
    var body: some View {
        
        Button(action: {
            action?()
        }) {
            VStack(alignment: .center) {
                
                if let text = text {
                    Text(text)
                        .font(.localizedFont(fontType: fontType, fontSize: fontSize))
                        .foregroundColor(textColor)
                        .frame(minWidth: 44)
                        .padding(12)
                        .background(bgColor)
                        .cornerRadius(cornerRadius)
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(textColor, lineWidth: 1)
            )
            
            
        }
    }
}

struct ServiceButtonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 10) {
            var titles = ["All", "Cleaning", "Cooking/Baking", "Childcare"]
            ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<3) { index in
                            ServiceButtonView(text: titles[index], textColor: index == 0 ? .appWhite : .appPrimaryColor , bgColor: index == 0 ? .appPrimaryColor : .appWhite)
                        }
                    }
                }
                .frame(height: 150)
            

        }
    }
}
