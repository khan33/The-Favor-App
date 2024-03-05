//
//  ProfilePicModal.swift
//  The Favour
//
//  Created by Atta khan on 26/04/2023.
//

import SwiftUI

struct ProfilePicModal: View {
    @Binding var show: Bool
    @Binding var showMainTab: Bool
    var body: some View {
        ZStack {
            if show {
                Color.black.opacity(show ? 0.3 : 0).edgesIgnoringSafeArea(.all)
                VStack(alignment: .center, spacing: 20) {
                    Image("profile")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)
                        .padding(30)
                    
                    FavorText(text: "Do you want to skip adding profile picture?", textColor: .appTitleColor, fontType: .bold, fontSize: 24, alignment: .center)
                    
                    
                    FavorText(text: "*Adding a picture will increase your chance of winning favors.", textColor: Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)), fontType: .regular, fontSize: 16, alignment: .center)
                    
                    FavorButton(text: "NO", width: .infinity, height: 60, bgColor: .appPrimaryColor) {
                        show.toggle()

                    }
                    .padding(.horizontal, 24)

                    
                    FavorButton(text: "Yes", width: .infinity, height: 60, textColor: .appPrimaryColor, bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
                        withAnimation(.linear(duration: 0.3)) {
                            showMainTab.toggle()
                        }

                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
                   
                }
                .border(Color.white, width: 1)
                .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                .cornerRadius(16)
                .padding()
            }
        }
        
    }
}

struct ProfilePicModal_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePicModal(show: .constant(true), showMainTab: .constant(true))
    }
}
