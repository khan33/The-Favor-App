//
//  ForgotPasswordView.swift
//  The Favour
//
//  Created by Atta khan on 16/04/2023.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var email: String = ""
    @StateObject var viewModel: AthenticationViewModel = AthenticationViewModel()
    @State private var isShowingSignupView = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            NavigationLink(destination: ResetPasswordView(email: viewModel.email), isActive: $viewModel.showMainTabView) { EmptyView() }
            //NavigationLink(destination: MainView(new_register: false), isActive: $isShowingSignupView) { EmptyView() }

            NavigationBarView(text: "")

            FavorText(text: "Forgot Password", textColor: .appBlack, fontType: .bold, fontSize: 36.0, alignment:.leading , lineSpace: 0)
                .padding(.horizontal, 24)
                .padding(.top, 40)
                .padding(.bottom, 12)
            
            FavorTextField(placeholder: "Email", leftImage: "Message", rightImage: nil, text: $viewModel.email)
    
            FavorButton(text: "Submit", width: .infinity, height: 60, bgColor: .appPrimaryColor) {
                viewModel.forgotPassword()
                
            }
            .opacity(viewModel.isEmailValid ? 1 : 0.5)
            .disabled(!viewModel.isEmailValid)

            
                        
            HStack(spacing: 0) {
                FavorText(text:"Don’t have an account?")
                
                FavorButton(text: "Sign up", width: 60, height: 60, textColor: .appPrimaryColor, bgColor: .white ) {
                    self.isShowingSignupView = true
                }
                
            }
            
            .frame(maxWidth: .infinity, alignment: .center)

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

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
