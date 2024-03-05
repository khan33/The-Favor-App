//
//  SignupView2.swift
//  The Favour
//
//  Created by Atta khan on 26/04/2023.
//

import SwiftUI

struct SignupView2: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isNext = false

    var body: some View {
        VStack (spacing: 16){
            NavigationLink(destination: DocumentUploadView(), isActive: $isNext) { EmptyView() }
            NavigationBarView(text: "Fill Your Profile")
                .padding()

            FavorText(text: "Steps 2 of 2", textColor: .appTitleColor, fontType: .bold, fontSize: 20, alignment: .center, lineSpace: 0)
                .padding(.horizontal, 8)
                .padding(.top, 30)
            
            
            FavorText(text: "We need to verify your information.\nPlease submit any documents from below to process your application.", textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)), fontType: .medium, fontSize: 18, alignment: .center, lineSpace: 0)
            
            
            DocumentButton(title: "ID Card / Driving License") {
                isNext = true
            }
            .padding(.top, 24)
//            DocumentButton(title: "Passport"){
//                isNext = true
//            }
//            DocumentButton(title: "Tax ID Number"){
//                isNext = true
//            }
            
            Spacer()
            
        }
        .navigationBarBackButtonHidden(true)
        
       
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

struct SignupView2_Previews: PreviewProvider {
    static var previews: some View {
        SignupView2()
    }
}
