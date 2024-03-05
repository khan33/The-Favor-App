//
//  DocumentUploadView.swift
//  The Favour
//
//  Created by Atta khan on 26/04/2023.
//

import SwiftUI

enum ImageSideType {
    case front
    case back
}

struct DocumentUploadView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isNext = false
    @State private var showModally = false
    
    @State private var selectedFrontImage: UIImage? = nil
    @State private var selectedBackImage: UIImage? = nil
    @State private var showImagePicker: Bool = false
    @State private var imageType: ImageSideType = .front
    @StateObject var viewModel: AthenticationViewModel = AthenticationViewModel()

    @State private var showAlert: Bool = false
    var body: some View {
        ZStack {
            VStack (spacing: 16){
                NavigationBarView(text: "Fill Your Profile")
                FavorText(text: "Steps 2 of 2", textColor: .appTitleColor, fontType: .bold, fontSize: 20, alignment: .center, lineSpace: 0)
                    .padding(.vertical, 18)
                
                FavorText(text: "Upload a jpg, png or jpeg, max size 1mb", textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)), fontType: .medium, fontSize: 18, alignment: .center, lineSpace: 0)
                    .padding(.bottom, 18)
                
                DocumentUploadButton(title: "Upload Id Front", image: $selectedFrontImage) {
                    imageType = .front
                    showImagePicker = true
                }
                
                DocumentUploadButton(title: "Upload Id Back", image: $selectedBackImage ) {
                    imageType = .back
                    showImagePicker = true
                }
                
                
                FavorButton(text: "Continue", width: .infinity, height: 60, bgColor: .appPrimaryColor) {
                    //showModally = true
                    
                    
                    if let frontImg = selectedFrontImage, let backImg = selectedBackImage {
                        if let mediaImage = Media(withImage: frontImg, forKey: "file_front_url"),
                           let mediaImage1 = Media(withImage: backImg, forKey: "file_back_url") {
                            
                            let params: [String : String] = ["file_type" : "passport"]
                            viewModel.updateUserProfileAttachment(params, [mediaImage, mediaImage1])
                        }
                        return
                    }
                    showAlert = true
                    
                    
                }
                Spacer()
            }
            .padding()
            
            CongratulationView(show: $showModally)
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")
        .sheet(isPresented: $showImagePicker) {
            if imageType == .front {
                ImagePickerView(selectedImage: $selectedFrontImage)
            } else {
                ImagePickerView(selectedImage: $selectedBackImage)

            }
        }
        .spinner(isShowing: $viewModel.shouldShowLoader)
        .fullScreenCover(isPresented: $viewModel.showMainTabView) {
            MainTabView()
        }
        
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Alert"),
                  message: Text("Upload your ID Card / Driving License photo."),
                  dismissButton: .default(Text("OK")))
        })


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

struct DocumentUploadView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentUploadView()
    }
}
