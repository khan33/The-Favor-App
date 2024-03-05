//
//  LoginView.swift
//  The Favour
//
//  Created by Atta khan on 16/04/2023.
//

import SwiftUI
import AuthenticationServices


struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var userViewModel = UserModeViewModel()

    
    @StateObject var viewModel: AthenticationViewModel = AthenticationViewModel()

    @State var email: String = ""
    @State var password: String = ""
    @State private var isChecked = false

    @State private var isShowingForgotPasswordView = false
    @State private var isShowingSignupView = false

    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Group {
                NavigationLink(destination: ForgotPasswordView(), isActive: $isShowingForgotPasswordView) { EmptyView() }
                NavigationLink(destination: MainTabView(), isActive: $viewModel.showMainTabView) { EmptyView() }
                NavigationLink(destination: SignupView1(), isActive: $isShowingSignupView) { EmptyView() }

            }
            NavigationBarView(text: "")
            FavorText(text: "Login to your Account", textColor: .appBlack, fontType: .bold, fontSize: 48, alignment:.leading , lineSpace: 0)
                .frame(maxWidth: .infinity, alignment: .leading)

            ScrollView(.vertical, showsIndicators: false) {
                Group {
                    FavorTextField(placeholder: "Email", leftImage: "Message", rightImage: nil, text: $viewModel.email)
                        .keyboardType(.emailAddress)
                    FavorTextField(placeholder: "password", leftImage: "Lock", rightImage: nil, isPassword: true, text: $viewModel.password)
                    Button(action: {
                        isChecked.toggle()
                    }) {
                        HStack {
                            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color.appPrimaryColor)
                            FavorText(text: "Remember me", textColor: .appBlack, fontType: .bold, fontSize: 14.0)
                        }
                    }
                    .padding(.vertical, 16)
                    FavorButton(text: "Login", width: .infinity, height: 60, bgColor: .appPrimaryColor) {
                        viewModel.performLogin()
                    }
                    .opacity(buttonOpacity)
                    .disabled(!viewModel.loginIsValid)
                    
                    FavorButton(text: "Forgot the password?", width: .infinity, height: 60, textColor: .appPrimaryColor, bgColor: .white) {
                        self.isShowingForgotPasswordView = true
                    }
                }
                HStack( alignment: .center, spacing: 24) {
                    FavorDividerView(width: 80, height: 1, bgColor: .appBorderColor)
                    FavorText(text:"or continue with")
                    FavorDividerView(width: 80, height: 1, bgColor: .appBorderColor)
                }
                .padding(.bottom, 16)
                .frame(maxWidth: .infinity)
                
                HStack(alignment: .center, spacing: 16) {
                    SocialIconView(imageName: "fb") { print("tap on facebook button")}
                    SocialIconView(imageName: "google") {
                        FirebaseAuth.shared.signInWithGoogle(presenting: getRootViewController()) { result in
                            switch result {
                            case .failure(let error):
                                print(error)
                            case .success(let data):
                                if let data = data?.user {
                                    viewModel.performSocialLogin(name: data.displayName ?? "", email: data.email ?? "", token: data.uid ?? "", login_type: "google")
                                }
                            }
                        }
                    }
                    SocialIconView(imageName: "apple") {
                        
                    }
                    .overlay {
                        SignInWithAppleButton { (request) in
                            // requesting param for apple login....
                            viewModel.nonce = randomNonceString()
                            request.requestedScopes = [.email, .fullName]
                            request.nonce = sha256(viewModel.nonce)
                        } onCompletion: { (result) in
                            // getting error or success....
                            switch result {
                            case .success(let user):
                                print(user)
                                guard let credential = user.credential as? ASAuthorizationAppleIDCredential else {
                                    return
                                }
                                viewModel.appleAuthentication(credential: credential)
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                        .signInWithAppleButtonStyle(.white)
                        .blendMode(.overlay)
                        .frame(width: 20, height: 30)
                    }

                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                
                
                
                Spacer()
                
                HStack(spacing: 0) {
                    FavorText(text:"Don’t have an account?")
                    
                    FavorButton(text: "Sign up", width: 60, height: 60, textColor: .appPrimaryColor, bgColor: .white ) {
                        self.isShowingSignupView = true
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            
            
        }
        .padding(.horizontal, 24)
        .navigationBarHidden(true)
        .navigationTitle("")
        .spinner(isShowing: $viewModel.shouldShowLoader)
//        .fullScreenCover(isPresented: $viewModel.showMainTabView) {
//            MainTabView()
//        }
        .overlay(
            Group {
                if viewModel.showMessage {
                    MessageView(message: viewModel.errorMessage, backgroundColor: Color.red)
                        .animation(.easeInOut)
                }
            }
                .onTapGesture {
                    viewModel.showMessage = false
                }
        )

    }
    
    var buttonOpacity: Double {
        return viewModel.loginIsValid ? 1 : 0.5
      }
    
    var btnBack : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
            Image("ic_back") // set image here
                .aspectRatio(contentMode: .fit)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
