//
//  SignupView1.swift
//  The Favour
//
//  Created by Atta khan on 26/04/2023.
//

import SwiftUI

struct SignupView1: View {
    @State var isUpdate: Bool = false
    @State private var isNext = false
    @State private var birthDate = Date()
    @State private var textEditorText:String = "Write down your thoughts"
    @State var calendarId: UUID = UUID()
    @StateObject var viewModel: AthenticationViewModel = AthenticationViewModel()
    @StateObject private var locationManager = LocationManager()

    @State var show: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            NavigationLink(destination: SignupAddPhoto(), isActive: $viewModel.showMainTabView) { EmptyView() }
            NavigationBarView(text: "Fill Your Profile")
            
            
            ScrollView(.vertical, showsIndicators: false) {
                FavorTextField(placeholder: "Full Name", leftImage: nil, rightImage: nil, text: $viewModel.fullName)
                    .padding(.top, 24)
                
                FavorTextField(placeholder: "Email", leftImage: nil, rightImage: "email", text: $viewModel.email)
                    .disabled(viewModel.isUpdate == false ? false : true)
                    .opacity(viewModel.isUpdate == false ? 1.0 : 0.5)
                
                
                if viewModel.isUpdate == false {
                    FavorTextField(placeholder: "Password", leftImage: nil, rightImage: "Lock", isPassword: true, text: $viewModel.password)
                        
                }
                
                
                FavorTextField(placeholder: "MM/DD/YYYY", leftImage: nil, rightImage: "calander", text: $viewModel.dateOfBirth) {
                    withAnimation {
                        show.toggle()
                    }
                }
                
                
                FavorTextField(placeholder: "Phone Number", leftImage: nil, rightImage: nil, text: $viewModel.phoneNumber)
                
//                FavorTextField(placeholder: "Address", leftImage: nil, rightImage: "location", text: $viewModel.address)
                
                
                FavorButton(text: "Continue", width: .infinity, height: 60, bgColor: .appPrimaryColor) {
//                    isNext = true
                    if let location = locationManager.currentLocation {
                        if viewModel.isUpdate == false {
                            viewModel.performSignup(address: locationManager.currentAddress, lat: String(location.coordinate.latitude), lng: String(location.coordinate.longitude))
                        } else {
                            viewModel.updateProfile()
                        }
                    }
                }
                .opacity(viewModel.signupIsValid ? 1 : 0.5)
                .disabled(!viewModel.signupIsValid)

                .padding(.top, 24)
                Spacer()
            }
        }
        .padding()
        .navigationBarHidden(true)
        .navigationTitle("")
        .spinner(isShowing: $viewModel.shouldShowLoader)
        .onAppear {
            viewModel.isUpdate = isUpdate
            locationManager.startUpdatingLocation()
            if viewModel.isUpdate != false { viewModel.retriveUser() }
        }
        .onDisappear {
            locationManager.stopUpdatingLocation()
        }
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
        
        
//        .toolBarPopover(show: $show) {
//            DatePicker("", selection: .constant(Date()), displayedComponents: [.date])
//                .datePickerStyle(.graphical)
//                .labelsHidden()
//                .id(calendarId)
//                .onChange(of: dateOfBirth) { _ in
//                    calendarId = UUID()
//                }
//                .onTapGesture {
//                    show.toggle()
//
//                }
//        }
    }
    
    
    var dateFormatter: DateFormatter {
           let formatter = DateFormatter()
           formatter.dateStyle = .long
           return formatter
       }
   
}

struct SignupView1_Previews: PreviewProvider {
    static var previews: some View {
        SignupView1()
    }
}
