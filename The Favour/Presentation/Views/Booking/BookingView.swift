//
//  BookingView.swift
//  The Favour
//
//  Created by Atta khan on 25/07/2023.
//

import SwiftUI
import StripePaymentSheet

struct BookingView: View {
    private let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let minDate = calendar.date(byAdding: .year, value: -120, to: .now)
        let maxDate = calendar.date(byAdding: .year, value: -18, to: .now)
        return minDate!...maxDate!
    }()
    @State private var selectedTime: Int = 0
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var desc: String = ""
    @State private var price: String = ""

    private var timeDict: [String: String] = ["09:00 AM" : "09:00",
                                               "10:00 AM"  : "10:00",
                                               "11:00 AM"  : "11:00",
                                               "12:00 PM"  : "12:00",
                                               "01:00 PM"  : "01:00",
                                               "02:00 PM"  : "02:00",
                                               "03:00 PM"  : "03:00",
                                               "04:00 PM"  : "04:00",
                                               "05:00 PM"  : "05:00",
                                               "06:00 PM"  : "06:00",
                                               "07:00 PM"  : "07:00",
                                               "08:00 PM"  : "08:00",
                                               "09:00 PM"  : "09:00",
                                               "10:00 PM"  : "10:00",
                                               "11:00 PM"  : "11:00"
    ]
    
    @StateObject var viewModel = BookingViewModel()
    var favor_id: Int
    init(favor_id: Int) {
        self.favor_id = favor_id
    }

    @State private var isPayNow: Bool = false
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 12) {
                NavigationLink(destination: BookingConfirmationView(viewModel: viewModel), isActive: $isPayNow) { EmptyView() }

                NavigationBarView(text: "Booking Details")
                    .padding(16)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        FavorText(text: "Select Date", textColor: .appTitleBlack, fontType: .bold, fontSize: 18, alignment: .center, lineSpace: 0)
                            .padding(.horizontal, 12)
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundColor(Color.appPrimaryColor)
                                .opacity(0.1)
                            DatePicker(selection: $viewModel.currentDate, in: Date.now...Date.init(timeIntervalSinceNow: (31 * 86600)), displayedComponents: .date) {
                                Text("Select a date")
                            }
                            .datePickerStyle(.graphical)
                            .accentColor(Color.appPrimaryColor) // Customize the selected date color
                            
                        }
                        .padding(.horizontal, 8)
                        
                        
                        
                        FavorText(text: "Choose Start Time", textColor: .appTitleBlack, fontType: .bold, fontSize: 16, alignment: .center, lineSpace: 0)
                            .padding(.horizontal, 12)
                        
                        
                        
                        ScrollView (.horizontal, showsIndicators: false) {
                            HStack(alignment: .center) {
                                let timeArray = Array(timeDict)
                                
                                ForEach(timeArray.indices, id: \.self) { index in
                                    let (key, value) = timeArray[index]
                                    
                                    Text(key)
                                        .font(.localizedFont(fontType: .bold, fontSize: 12))
                                        .foregroundColor(index == selectedTime ? .appWhite : .appPrimaryColor )
                                        .frame(minWidth: 66)
                                        .padding(12)
                                        .background(index == selectedTime ? Color.appPrimaryColor : Color.appWhite)
                                        .cornerRadius(16)
                                        .onTapGesture {
                                            selectedTime = index
                                            viewModel.time = key
                                        }
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(index == selectedTime ? Color.appWhite: Color.appPrimaryColor, lineWidth: 1)
                                        )
                                }
                            }
                        }
                        .padding(.horizontal, 8)
                        Group {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundColor(.appTextFieldColor)
                                    .frame(height: 100)
                                    .border(.appWhite, width: 1, cornerRadius: 12)
                                TextViewWrapper(text: $viewModel.details)
                                    .padding(8)
                                    .frame(height: 100)
                                    .cornerRadius(8)
                            }
                            
                            FavorTextField(placeholder: "Price", leftImage: nil, rightImage: nil, text: $viewModel.favorPrice)
                            .keyboardType(.numberPad)
                            
                            HStack {
                                Text("Book Favor")
                                    .font(.localizedFont(fontType: .bold, fontSize: 14))
                                    .onTapGesture {
                                        viewModel.newBookingFavor(id: String(favor_id)) { _ in
                                            isPayNow.toggle()
                                        }
                                    }
                            }
                            .frame(height: 48)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color.appPrimaryColor)
                            .cornerRadius(6)
                            .accessibility(identifier: "Buy button")
                            
                        }
                        .padding(.horizontal, 12)
                    }
                    .padding(.vertical)
                }
            }
        }
        .navigationBarHidden(true) // Hide the navigation bar on this screen
        .navigationTitle("")
        .spinner(isShowing: $viewModel.shouldShowLoader)
        .alert(isPresented: $viewModel.isAlertShow, content: {
            Alert(title: Text("Alert"),
                  message: Text(viewModel.alertMsg),
                  dismissButton: .default(Text("OK"), action: {
                presentationMode.wrappedValue.dismiss()
            }))
        })
    }
}

struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView(favor_id: 5)
    }
}



struct BookingConfirmationView: View {
    @ObservedObject var viewModel: BookingViewModel
    
    init(viewModel: BookingViewModel) {
        self.viewModel = viewModel
    }
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            Image("cong")
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 180)
                .padding(30)
            FavorText(text: "Congratulations", textColor: .appTitleColor, fontType: .bold, fontSize: 24, alignment: .center)
            FavorText(text: "Your faovr has been booked. Now you need to pay for the service.", textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)), fontType: .regular, fontSize: 16, alignment: .center)
                .frame(maxWidth: .infinity, alignment: .center)
            if let paymentSheet = viewModel.paymentSheet {
                PaymentSheet.PaymentButton(
                    paymentSheet: paymentSheet,
                    onCompletion: viewModel.onCompletion
                ) {
                    HStack {
                        Text("Pay Now!")
                    }
                    .frame(height: 48)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.appPrimaryColor)
                    .cornerRadius(6)
                    .accessibility(identifier: "Buy button")
                }
            }
        }
        .padding()
        .alert(isPresented: $viewModel.isAlertShow, content: {
            Alert(title: Text("Alert"),
                  message: Text(viewModel.alertMsg),
                  dismissButton: .default(Text("OK"), action: {
                viewModel.isAlertShow.toggle()
                viewModel.alertMsg = ""
                presentationMode.wrappedValue.dismiss()
            }))
        })

    }
}
