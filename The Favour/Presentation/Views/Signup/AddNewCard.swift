//
//  AddNewCard.swift
//  The Favour
//
//  Created by Atta khan on 26/04/2023.
//

import SwiftUI

struct AddNewCard: View {
    @State var cardName: String = ""
    @State var cardNumber: String = ""
    @State var expiryDate: String = ""
    @State var cvv: String = ""
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isNext = false

    var body: some View {
        VStack (alignment: .leading){
            NavigationLink(destination: CreateNewPinView(), isActive: $isNext) { EmptyView() }

            Image("card")
                .resizable()
                .scaledToFit()
            
            
            
            
            FavorText(text: "Card Name", textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)), fontType: .bold, fontSize: 18, alignment: .center, lineSpace: 0)
                .padding(.top, 20)
            FavorTextField(placeholder: "Card Name", leftImage: nil, rightImage: nil, text: $cardName)
                .padding(.bottom, 14)
            
           
            FavorText(text: "Card Number", textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)), fontType: .bold, fontSize: 18, alignment: .center, lineSpace: 0)
            FavorTextField(placeholder: "Card Number", leftImage: nil, rightImage: nil, text: $cardNumber)
                .padding(.bottom, 14)
            HStack (spacing: 24) {
                VStack (alignment: .leading) {
                    FavorText(text: "Expiry Date", textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)), fontType: .bold, fontSize: 18, alignment: .center, lineSpace: 0)

                    FavorTextField(placeholder: "Expiry Date", leftImage: nil, rightImage: nil, text: $cardName)
                }
                VStack(alignment: .leading) {
                    FavorText(text: "CVV", textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)), fontType: .bold, fontSize: 18, alignment: .center, lineSpace: 0)

                    FavorTextField(placeholder: "CVV", leftImage: nil, rightImage: nil, text: $cardName)
                }
            }
            .padding(.bottom, 30)
            FavorButton(text: "Add New Card", width: .infinity, height: 60, bgColor: .appPrimaryColor) {
                isNext = true
            }
            
           
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        .navigationTitle("Add New Card")
        .padding()
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

struct AddNewCard_Previews: PreviewProvider {
    static var previews: some View {
        AddNewCard()
    }
}
