//
//  FavorBookingDetailView.swift
//  The Favour
//
//  Created by Atta khan on 07/08/2023.
//

import SwiftUI

struct FavorBookingDetailView: View {
    var booking_detail:  BookingData?
    init(booking_detail: BookingData?) {
        self.booking_detail = booking_detail
    }
    @StateObject var viewModel: BookingViewModel = BookingViewModel()
    @State private var showModally = false
    @State private var showMainTabView = false
    
    var body: some View {
        ZStack {
            VStack () {
                VStack(alignment: .leading, spacing: 16) {
                    NavigationBarView(text: "My Booking Detail")
                    FavorText(text: booking_detail?.favor_details?.title ?? "", textColor: Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)), fontType: .bold, fontSize: 20, alignment: .leading, lineSpace: 0)
                        .padding(.top, 20)
                    
                    
                    HStack {
                        FavorButton(text: booking_detail?.favor_details?.category ?? "" , width: 68, height: 24, textColor: .appPrimaryColor, fontType: .regular, fontSize: 10,  bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
                        }
                        Spacer()
                        AddressView(address: booking_detail?.favor_details?.address ?? "")
                    }
                    FavorDividerView(width: .infinity, height: 0.5)
                    BookingInfoView
                    Spacer()
                }
                .padding([.horizontal, .top], 24)
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
                        FavorButton(text: "Chat", width: .infinity, height: 55, textColor: .appPrimaryColor, bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
                        }
                        if booking_detail?.status == .completed {
                            FavorButton(text: UtilityManager.shared.buttonText(for: booking_detail?.status ?? .pending), width: .infinity, height: 55, bgColor: .appPrimaryColor) {
                                if booking_detail?.status == .completed {
                                    viewModel.bookingApprovedByBuyer(bookingId: booking_detail?.booking_id ?? 0)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                }
            }
            
            FavorRatingView(show: $viewModel.show_rating_popup, viewModel: viewModel, bookingId: String(booking_detail?.booking_id ?? 0))
                .transition(.move(edge: .bottom))
            PopupView(show: $viewModel.isShowPopup, message: viewModel.popup_message, messaeg_detail: "")
                .transition(.move(edge: .bottom))


        }
        .navigationBarHidden(true)
        .navigationTitle("")
        .edgesIgnoringSafeArea(.bottom)
        
    }
    private var BookingInfoView: some View {
        VStack(alignment: .leading, spacing: 10) {
            FavorText(text: "Price Quoted", textColor: Color(red: 0, green: 0.59, blue: 0.54), fontType: .bold, fontSize: 18, alignment: .center, lineSpace: 0)
            FavorText(text: "$\(String(describing: booking_detail?.total_price ?? 0))", textColor: .appWhite, fontType: .bold, fontSize: 24, alignment: .center, lineSpace: 0)
                    
            FavorText(text: "Details", textColor: Color(red: 0, green: 0.59, blue: 0.54), fontType: .bold, fontSize: 18, alignment: .center, lineSpace: 0)
            FavorText(text: booking_detail?.details ?? "", textColor: .appWhite, fontType: .regular, fontSize: 16, alignment: .leading, lineSpace: 0)
            
            HorizontalTwoLabelView(label1: "Date & Time", label2: "\(booking_detail?.favor_date ?? "") \(booking_detail?.favor_time ?? "")", textColorLbl1 : Color(red: 0, green: 0.59, blue: 0.54), fontTypeLbl1: .medium, fontSizeLbl1: 14, textColorLbl2: .appWhite, fontTypeLbl2: .semiBold, fontSizeLbl2: 16)
                
            
            HorizontalTwoLabelView(label1: "Location", label2: booking_detail?.address ?? "", textColorLbl1 : Color(red: 0, green: 0.59, blue: 0.54), fontTypeLbl1: .medium, fontSizeLbl1: 14, textColorLbl2: .appWhite, fontTypeLbl2: .semiBold, fontSizeLbl2: 16)
            
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
