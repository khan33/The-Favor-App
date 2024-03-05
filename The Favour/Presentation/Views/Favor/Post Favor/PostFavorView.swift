//
//  PostFavorView.swift
//  The Favour
//
//  Created by Atta khan on 17/05/2023.
//

import SwiftUI

struct PostFavorView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel: FavorViewModel = FavorViewModel()
    @State var pickLocation: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            NavigationBarView(text: viewModel.screenTitle)
                .padding(.bottom, 24)
            
            ScrollView {
                VStack (spacing: 10) {
                    service_picker_view
                    title_view
                    description_view
                    FavorTextField(placeholder: "Pick Location", leftImage: nil, rightImage: "location", text: $viewModel.address) {
                        pickLocation = true
                    }
                    //image_uploading_view
                    
                    FavorButton(text: "Post", width: .infinity, height: 60, bgColor: .appPrimaryColor) {
                        viewModel.postFavor(nil)
//                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding(.top, 12)
                    .opacity(viewModel.isValidPost ? 1 : 0.5)
                    .disabled(!viewModel.isValidPost)

                }
            }
        }
        .padding(24)
        .navigationBarHidden(true)
        .navigationTitle("")
        .spinner(isShowing: $viewModel.shouldShowLoader)
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePickerView(selectedImage: $viewModel.selectedImage)
        }
        .alert(isPresented: $viewModel.isAlertShow, content: {
            Alert(title: Text("Alert"),
                  message: Text(viewModel.alertMsg),
                  dismissButton: .default(Text("OK"), action: {
                    viewModel.getUserFavor()
                    presentationMode.wrappedValue.dismiss()
            }))
        })
        
        .fullScreenCover(isPresented: $pickLocation) {
            PickLocationView(address: $viewModel.address, lat: $viewModel.lat, lng: $viewModel.lng, isPresented: $pickLocation)
        }
        .onAppear {
            viewModel.getService()
        }
        .onDisappear {
            viewModel.address = ""
            viewModel.title = ""
            viewModel.desc = ""
            viewModel.lat = 0.0
            viewModel.lng = 0.0
            viewModel.address = ""
            viewModel.favor_id = "0"
            viewModel.showImagePicker = false
            viewModel.selectedImage = nil
            viewModel.selectedService = nil
        }

    }
    
    
}

struct PostFavorView_Previews: PreviewProvider {
    static var previews: some View {
        PostFavorView(viewModel: FavorViewModel())
    }
}


extension PostFavorView {
    private var service_picker_view: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.appTextFieldColor)
                .border(.appWhite, width: 1, cornerRadius: 12)
            HStack {

                TextFieldWithInputView(viewModel: viewModel, placeholder: "Select Service", selectedData: $viewModel.selectedService)


                    .foregroundColor(.appBlack)
                    .font(.localizedFont(fontType: .regular, fontSize: 14))
                Image("down")
            }
            .padding(.horizontal)
        }
        .frame(height: 60)
    }
    
    private var title_view: some View {
        
        VStack(alignment: .leading) {
            FavorTextField(placeholder: "Title", leftImage: nil, rightImage: nil, text: $viewModel.title)
        }
    }
    
    private var description_view: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.appTextFieldColor)
                    .frame(height: 100)
                    .border(.appWhite, width: 1, cornerRadius: 12)
                
                    TextViewWrapper(text: $viewModel.desc)
                        .padding(8)
                        .frame(height: 100)
                        .cornerRadius(8)
                   
                }
            FavorText(text: "Minimum 20 chars long", textColor: .appLightGrey, fontType: .regular, fontSize: 11, alignment:.leading , lineSpace: 0)
                .frame(maxWidth: .infinity, alignment: .trailing)

        }

    }

    
    private var image_uploading_view: some View {
        VStack {
            FavorButton(text: "Upload Image", width: .infinity, height: 44, textColor: .appPrimaryColor, bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
                viewModel.showImagePicker = true
            }
            if viewModel.showImagePicker == false && viewModel.selectedImage == nil {
                FavorText(text: "* Require Image.", textColor: .red, fontType: .regular, fontSize: 9, alignment: .leading, lineSpace: 0)
                    .padding(.horizontal, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            if let image = viewModel.selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
//            else if let imgURL = viewModel.imageURL {
//                let url = URL(string: imgURL)
//                AsyncImage(url: url) { img in
//                    img.resizable()
//                        .scaledToFit()
//                        .frame(width: 200, height: 200)
//                } placeholder: {
//
//                }
//
//            }
        }

    }
    
}
