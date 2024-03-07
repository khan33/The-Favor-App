//
//  SignupView1.swift
//  The Favour
//
//  Created by Atta khan on 26/04/2023.
//

import SwiftUI
import PartialSheet

struct SignupView1: View {
    @State var isUpdate: Bool = false
    @State private var isNext = false
    @State private var birthDate = Date()
    @State private var textEditorText:String = "Write down your thoughts"
    @State var calendarId: UUID = UUID()
    @StateObject var viewModel: AthenticationViewModel = AthenticationViewModel()
    @StateObject private var locationManager = LocationManager()
    let iPhoneStyle = PSIphoneStyle(
        background: .solid(Color(UIColor.systemBackground)),
        handleBarStyle: .solid(Color.secondary),
        cover: .enabled(Color(red: 0.04, green: 0.06, blue: 0.11).opacity(0.69)),
        cornerRadius: 12
    )
    @State var isDatePickerVisible = false
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
                
                
                FavorTextField(placeholder: "MM/DD/YYYY", leftImage: nil, rightImage: "calander", text: $viewModel.dateOfBirth)
                    .onTapGesture {
                        isDatePickerVisible.toggle()
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
        .sheet(isPresented: $isDatePickerVisible, content: {
            DateTimePickerView(selectedDate: $viewModel.selectedPickDate, isPresented: $isDatePickerVisible)
                .presentationDetents([.medium])
        })
        

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
    }
    
    
    var dateFormatter: DateFormatter {
           let formatter = DateFormatter()
           formatter.dateStyle = .long
           return formatter
       }
   
}

struct DateTimePickerView: View {
    @Binding var selectedDate: Date
    @Binding var isPresented: Bool
    @State private var pickerDate: Date = Date()

    var minimumDate: PartialRangeThrough<Date> {
        let maxDate = Calendar.current.date(byAdding: .year, value: -18, to: Date())!
        return ...maxDate
    }

    var body: some View {
        VStack {
            VStack {
                DatePicker("Select Birth Date ", selection: $pickerDate, in: minimumDate , displayedComponents: [.date])
                    .transformEffect(.init(scaleX: 1, y: 1))
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding(16)
                    .background(Color.appLightGrey.opacity(0.4))
                    .cornerRadius(20)
                    .accentColor(Color.appPrimaryColor)
            }.padding(.top, 20)
            Divider()
                .padding(.vertical, 8)

            
            HStack(alignment: .center) {
                Button(action: {
                    isPresented = false
                    selectedDate = pickerDate
                }, label: {
                    Text("OK")
                        .foregroundColor(Color.black)
                        .background(
                            Color.black
                                .frame(height: 1)
                                .offset(y: 10)
                        )
                })
            }

        }
        .onAppear(perform: onAppear)
        .background(Color.appWhite)
        .padding(20)
        
    }

    private func onAppear() {
        self.pickerDate = minimumDate.upperBound
    }

}
