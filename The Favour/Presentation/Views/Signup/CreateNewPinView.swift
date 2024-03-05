//
//  CreateNewPinView.swift
//  The Favour
//
//  Created by Atta khan on 26/04/2023.
//

import SwiftUI

struct CreateNewPinView: View {
    @State private var otpView: OTPTextView?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isNext = false

    var body: some View {
        VStack {
            NavigationLink(destination: FigureprintView(), isActive: $isNext) { EmptyView() }

            FavorText(text: "Add a PIN number to make your account more secure.", textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)), fontType: .medium, fontSize: 18, alignment: .center, lineSpace: 0)
            otpTextView
            
            FavorButton(text: "Continue", width: .infinity, height: 60, bgColor: .appPrimaryColor) {
                isNext = true
            }
            .padding(.horizontal, 20)
            .padding(.top, 24)
        }
        .onAppear {
            otpView = OTPTextView()
            otpView?.textOTPView.becomeFirstResponder()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        .navigationTitle("Create New PIN")
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
    
    
    private var otpTextView: some View {
        VStack(alignment: .leading, spacing: 4) {
            otpView
                .frame(width: UIScreen.screenWidth - 48, height: 48)
                .padding(24)
        }
    }
}

struct CreateNewPinView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewPinView()
    }
}
