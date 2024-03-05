//
//  FigureprintView.swift
//  The Favour
//
//  Created by Atta khan on 26/04/2023.
//

import SwiftUI

struct FigureprintView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            FavorText(text: "Add a fingerprint to make your account more secure", textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)), fontType: .medium, fontSize: 18, alignment: .center, lineSpace: 0)
           

            Image("finger")
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 180)
                .padding(30)

            FavorText(text: "Please put your finger on the fingerprint scanner to get started.", textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)), fontType: .medium, fontSize: 18, alignment: .center, lineSpace: 0)
            Spacer()

            HStack {
                FavorButton(text: "Skip", width: .infinity, height: 60, textColor: .appPrimaryColor, bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
                }
                FavorButton(text: "Continue", width: .infinity, height: 60, bgColor: .appPrimaryColor) {

                }

            }
            
        }
        .padding(.horizontal, 20)
        .padding(.top, 24)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        .navigationTitle("Set Your Fingerprint")
    }
    
    var btnBack : some View { Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                Image("ic_back") // set image here
                    .aspectRatio(contentMode: .fit)
                }
            }
        }
}

struct FigureprintView_Previews: PreviewProvider {
    static var previews: some View {
        FigureprintView()
    }
}
