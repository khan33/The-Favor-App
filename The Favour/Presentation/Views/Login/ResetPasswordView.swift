//
//  ResetPasswordView.swift
//  The Favour
//
//  Created by Atta khan on 18/07/2023.
//

import SwiftUI

struct ResetPasswordView: View {
    var email: String
    @StateObject var viewModel: AthenticationViewModel = AthenticationViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            NavigationLink(destination: LoginView(), isActive: $viewModel.showMainTabView) { EmptyView() }

            NavigationBarView(text: "")
            FavorText(text: "Reset Password", textColor: .appBlack, fontType: .bold, fontSize: 36.0, alignment:.leading , lineSpace: 0)
                .padding(.horizontal, 24)
                .padding(.top, 40)
                .padding(.bottom, 12)
            
            FavorTextField(placeholder: "Token", leftImage: "Lock", rightImage: nil, text: $viewModel.code)
            
            
            FavorTextField(placeholder: "Password", leftImage: "Lock", rightImage: nil, isPassword: true, text: $viewModel.password)
            
            FavorTextField(placeholder: "Confirm Password", leftImage: "Lock", rightImage: nil, isPassword: true, text: $viewModel.confirmPassord)
    
            FavorButton(text: "Submit", width: .infinity, height: 60, bgColor: .appPrimaryColor) {
                viewModel.resetPassword(email: email)
            }
            .opacity(viewModel.isResetPasswordFormValid ? 1 : 0.5)
            .disabled(!viewModel.isResetPasswordFormValid)

            Spacer()
            
            
        }
        .padding(.horizontal,24)
        .navigationBarHidden(true)
        .navigationTitle("")
        .spinner(isShowing: $viewModel.shouldShowLoader)
        .alert(item: $viewModel.alertType) { alertType in
            Alert(title: Text(alertType == .success ? "Success" : "Error"),
                  message: Text(viewModel.errorMessage),
                  dismissButton: .default(Text("OK")))
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView(email: "")
    }
}
