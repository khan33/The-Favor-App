//
//  DocumentButton.swift
//  The Favour
//
//  Created by Atta khan on 26/04/2023.
//

import SwiftUI

struct DocumentButton: View {
    let title: String
    var action: (() -> Void)?
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
            .fill(Color(#colorLiteral(red: 0.9450980424880981, green: 0.9058823585510254, blue: 1, alpha: 1)))
            .frame(width: .infinity, height: 73)
            HStack {
                FavorText(text: title, textColor: Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)), fontType: .semiBold, fontSize: 18)
                    .padding(.leading, 24)
                Spacer()
                Image(systemName: "chevron.right")
                    .padding(.trailing, 24)
            }
        }
        .onTapGesture {
            action?()
        }
        .padding(.horizontal, 16)
    }
}

struct DocumentButton_Previews: PreviewProvider {
    static var previews: some View {
        DocumentButton(title: "ID Card / Driving License")
    }
}
