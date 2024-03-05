//
//  MyBookingDetail.swift
//  The Favour
//
//  Created by Atta khan on 30/07/2023.
//

import SwiftUI
import CoreLocation


struct MyBookingDetail: View {
    var bookingId:  Int?
    init(bookingId: Int) {
        self.bookingId = bookingId
//        viewModel.getFavorBookingById(bookingId: self.bookingId ?? 0)
    }
    @StateObject var viewModel: BookingViewModel = BookingViewModel()
    @State private var showModally = false
    @State private var showMainTabView = false
    @StateObject var locationManager: LocationManager = LocationManager()
    var distance: CLLocationDistance = 0.0
    @State var isChatview: Bool = false
    @State var isPresented: Bool = false

    var body: some View {
        ZStack {
            VStack () {
                VStack(alignment: .leading, spacing: 16) {
                    NavigationLink(destination: ChatView(chat: Chat.sampleChat[0]), isActive: $isChatview) { EmptyView() }
                    NavigationBarView(text: "My Booking Detail")
                    FavorText(text: viewModel.booking_data?.favor_details?.title ?? "", textColor: Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)), fontType: .bold, fontSize: 20, alignment: .leading, lineSpace: 0)
                        .padding(.top, 20)
                    
                    
                    HStack() {
                        FavorText(text: viewModel.booking_data?.favor_details?.category ?? "", textColor: .appPrimaryColor, fontType: .regular, fontSize: 10, alignment: .center, lineSpace: 0)
                            .padding(8)
                            .background(Color(red: 0.945, green: 0.906, blue: 1))
                            .cornerRadius(8)
                            .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
                            .frame(maxWidth: 120, alignment: .leading)
                        AddressView(address: viewModel.booking_data?.favor_details?.address ?? "")
                            .frame(maxWidth: .infinity, alignment: .trailing) // Expand trailing label
                        

                    }
                    FavorDividerView(width: .infinity, height: 0.5)
                    BookingInfoView
                    
                    MapView(locationManager: locationManager, viewModel: FavorViewModel(), isPresented: $isPresented)
                    
                    
                    Spacer()
                }
                .padding(.top, 16)
                .padding([.horizontal], 24)
                .padding(.bottom, 0)
                
                
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 110)
                    
                    Rectangle()
                        .frame(height: 110)
                        .foregroundColor(.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.appBorderColor, lineWidth: 1)
                            
                        )
                    HStack {
                        if let status = viewModel.booking_data?.status {
                            if status == .pending {
                                FavorButton(text: "Accept", width: .infinity, height: 50, textColor: .appWhite , bgColor: .appPrimaryColor) {
                                    viewModel.sellerActionOnBooking(bookingId: viewModel.booking_data?.booking_id ?? 0, status: ButtonStatus.accepted)
                                }
                                FavorButton(text: "Reject", width: .infinity, height: 50, textColor: .appWhite , bgColor: .red) {
                                    viewModel.sellerActionOnBooking(bookingId: viewModel.booking_data?.booking_id ?? 0, status: ButtonStatus.rejected)
                                }
                            } else if status == .accepted {
                                FavorButton(text: "Start Favor", width: .infinity, height: 50, textColor: .appWhite , bgColor: UtilityManager.shared.buttonColor(for: viewModel.booking_data?.status ?? .pending)) {
                                        buttonAction(for: status)
                                }
                            } else {
                                FavorButton(text: UtilityManager.shared.buttonText(for: status), width: .infinity, height: 50, textColor: .appWhite , bgColor: UtilityManager.shared.buttonColor(for: viewModel.booking_data?.status ?? .pending)) {
                                        buttonAction(for: status)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                }
            }
            
            PopupView(show: $viewModel.isShowPopup, message: viewModel.popup_message, messaeg_detail: "")
                .transition(.move(edge: .bottom))


        }
        .navigationBarHidden(true)
        .navigationTitle("")
        .edgesIgnoringSafeArea(.bottom)
        .spinner(isShowing: $viewModel.shouldShowLoader)
        .onAppear {
            viewModel.getFavorBookingById(bookingId: bookingId!)
        }
    }
}

struct MyBookingDetail_Previews: PreviewProvider {
    static var previews: some View {
        MyBookingDetail(bookingId: 1)
    }
}

extension MyBookingDetail {
    
    private func buttonAction(for state: ButtonStatus) {
        switch state {
            case .pending:
                return
            case .inProgress:
                viewModel.sellerCompleteFavor(bookingId: viewModel.booking_data?.booking_id ?? 0)
            case .accepted:
                viewModel.sellerStartFavor(bookingId: viewModel.booking_data?.booking_id ?? 0)
            case .rejected:
                return
            case .completed:
                return
            case .buyer_approved:
                return

        }
    }
    func calculateDistance(to location: CLLocation) -> String {
        if let currentLocation = locationManager.currentLocation {
            //let location = CLLocation(latitude: 37.0987, longitude: -122.7459)
            let metersDistance = currentLocation.distance(from: location)
            let milesDistance = metersDistance / 1609.34
            let roundedDistance = String(format: "%.2f", milesDistance)

            return roundedDistance
        }
        return "0"
    }
    
    
    private var BookingInfoView: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 8) {
                if let image = viewModel.booking_data?.profile_photo, image != "" {
                    AsyncImage(url: URL(string: image)!) { img in
                        img
                            .resizable()
                            .frame(width: 48, height: 48)
                            .clipShape(Circle())
                    } placeholder: {
                        Image("user_profile")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48, height: 48)
                            .padding(.leading, 8)
                    }
                    
                    
                } else {
                    Image("user_profile")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                        .padding(.leading, 8)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    FavorText(text: viewModel.booking_data?.user_name ?? "", textColor: .appWhite, fontType: .bold, fontSize: 18, alignment: .center, lineSpace: 0)
                    FavorText(text: "\(viewModel.booking_data?.total_price ?? 0)$", textColor: .appWhite, fontType: .bold, fontSize: 24, alignment: .center, lineSpace: 0)

                }
                .padding(12)
                Spacer()
                ZStack {
                    Circle()
                        .fill(Color.appWhite)
                        .frame(width: 30, height: 30)
                    Image(systemName: "ellipsis.message.fill")
                        .foregroundColor(.appTitleColor)
                }
                .padding(.trailing, 20)
                .onTapGesture {
                    isChatview = true
                }

            }
            
            FavorText(text: "Details", textColor: Color(red: 0, green: 0.59, blue: 0.54), fontType: .bold, fontSize: 18, alignment: .center, lineSpace: 0)
            FavorText(text: viewModel.booking_data?.details ?? "", textColor: .appWhite, fontType: .regular, fontSize: 16, alignment: .leading, lineSpace: 0)

            
            HorizontalTwoLabelView(label1: "Date & Time", label2: "\(viewModel.booking_data?.favor_date ?? "") \(viewModel.booking_data?.favor_time ?? "")", textColorLbl1 : Color(red: 0, green: 0.59, blue: 0.54), fontTypeLbl1: .medium, fontSizeLbl1: 14, textColorLbl2: .appWhite, fontTypeLbl2: .semiBold, fontSizeLbl2: 16)
            HorizontalTwoLabelView(label1: "Location", label2: viewModel.booking_data?.address ?? "", textColorLbl1 : Color(red: 0, green: 0.59, blue: 0.54), fontTypeLbl1: .medium, fontSizeLbl1: 14, textColorLbl2: .appWhite, fontTypeLbl2: .semiBold, fontSizeLbl2: 16)
            
            HorizontalTwoLabelView(label1: "Distance", label2: "\(calculateDistance(to: CLLocation(latitude: viewModel.booking_data?.lat ?? 0.0, longitude: viewModel.booking_data?.lng ?? 0.0))) miles away", textColorLbl1 : Color(red: 0, green: 0.59, blue: 0.54), fontTypeLbl1: .medium, fontSizeLbl1: 14, textColorLbl2: .appWhite, fontTypeLbl2: .semiBold, fontSizeLbl2: 16)
            
        }
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color(#colorLiteral(red: 0.1333333333, green: 0.7333333333, blue: 0.6117647059, alpha: 1)), location: 0),
                    .init(color: Color(#colorLiteral(red: 0.2078431373, green: 0.8705882353, blue: 0.737254902, alpha: 1)), location: 1)]),
                startPoint: UnitPoint(x: 1.0000000298023233, y: 1.000000029802323),
                endPoint: UnitPoint(x: 1.1102230246251565e-16, y: -4.440892098500626e-16))
        )
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        
    }
}
