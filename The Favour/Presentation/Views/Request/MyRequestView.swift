//
//  MyRequestView.swift
//  The Favour
//
//  Created by Atta khan on 16/05/2023.
//

import SwiftUI

struct MyRequestView: View {
    @StateObject var viewModel: BookingViewModel = BookingViewModel()    
    var favor_id: Int
    init(favor_id: Int) {
        self.favor_id = favor_id
    }
    @State var bookingId: Int = 0
    var body: some View {
        ZStack {
            VStack {
                NavigationLink(destination: MyBookingDetail(bookingId: bookingId), isActive: $viewModel.detail_page) { EmptyView() }
                
                NavigationBarView(text: "My Request")
                
                if viewModel.sellerBookingRequest.isEmpty {
                    Spacer()
                    FavorText(text: "There is no booking for this favor.!", textColor: Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)), fontType: .bold, fontSize: 24, alignment: .leading, lineSpace: 0)
                    Spacer()
                }
                else {
                    
                    ScrollView {
                        ForEach(viewModel.sellerBookingRequest.indices, id: \.self) { index in
                            RequestView(booking_data: viewModel.sellerBookingRequest[index]) {
                                bookingId = viewModel.sellerBookingRequest[index].booking_id ?? 0
                                viewModel.detail_page = true
                            }
                        }
                    }
                }
                
                
                
                PopupView(show: $viewModel.isShowPopup, message: viewModel.popup_message, messaeg_detail: "")
                    .transition(.move(edge: .bottom))
                
            }
            .navigationBarHidden(true)
            .navigationTitle("")
            .padding(24)
            .background( Color(#colorLiteral(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)))
            .onAppear {
                viewModel.getFavorListBySeller(id: String(favor_id))
            }
        }
    }
}

struct MyRequestView_Previews: PreviewProvider {
    static var previews: some View {
        MyRequestView(favor_id: 1)
    }
}
