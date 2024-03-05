//
//  SignupAddPhoto.swift
//  The Favour
//
//  Created by Atta khan on 26/04/2023.
//

import SwiftUI

struct SignupAddPhoto: View {
    @State private var showModally = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isNext = false
    @State private var selectedImage: UIImage? = nil
    @State private var showImagePicker: Bool = false
    @StateObject var viewModel: AthenticationViewModel = AthenticationViewModel()

    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 24) {
                NavigationLink(destination: SignupView2(), isActive: $viewModel.showMainTabView) { EmptyView() }
                NavigationBarView(text: "Fill Your Profile")

                FavorText(text: "Steps 1 of 2", textColor: .appTitleColor, fontType: .bold, fontSize: 20, alignment: .center, lineSpace: 0)
                    .padding(.top, 36)
                    .padding(.bottom, 16)
                
                ZStack(alignment: .bottomTrailing) {
                    if let img = selectedImage {
                        AvatarView(image: Image(uiImage:  img), size: 200, profileImageURL: nil)
                    } else {
                        AvatarView(image: Image("avatar"), size: 200, profileImageURL: nil)
                    }
                    
                    Image("edit_profile")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 36, height: 36)
                        .padding(.all, 8)
                        .onTapGesture {
                            showImagePicker = true
                        }
                    
                }
                FavorButton(text: "Continue", width: .infinity, height: 60, bgColor: .appPrimaryColor) {
                    if let image = selectedImage {
                        guard let mediaImage = Media(withImage: image, forKey: "profile_photo") else { return }
                        viewModel.updateUserProfileAttachment(nil, [mediaImage])                        
                    }

                    
                }
                
                FavorButton(text: "Skip", width: .infinity, height: 60, textColor: .appPrimaryColor, bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
                    withAnimation(.linear(duration: 0.3)) {
                        showModally.toggle()
                    }
                    
                    
                }
                Spacer()
                
                
            }
            .padding()
            ProfilePicModal(show: $showModally, showMainTab: $viewModel.showMainTabView)
                .transition(.move(edge: .bottom))
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")
        .sheet(isPresented: $showImagePicker) {
            ImagePickerView(selectedImage: $selectedImage)
        }
        .spinner(isShowing: $viewModel.shouldShowLoader)
        .fullScreenCover(isPresented: $isNext) {
            MainTabView()
        }

    }
}

struct SignupAddPhoto_Previews: PreviewProvider {
    static var previews: some View {
        SignupAddPhoto()
    }
}
