//
//  NavigationBarView.swift
//  The Favour
//
//  Created by Atta khan on 09/05/2023.
//

import SwiftUI

struct NavigationBarView: View {
    let text: String
    var icon: String = "ic_back"
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var action: (() -> Void)? = nil

    var body: some View {
        
        HStack(spacing: 12) {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
                action?()
            }) {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            FavorText(text: text, textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)), fontType: .bold, fontSize: 24, alignment: .leading, lineSpace: 0)
            Spacer()
        }
    }
}

struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView(text: "Security", icon: "ic_back")
    }
}
