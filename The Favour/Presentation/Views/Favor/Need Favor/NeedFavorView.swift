//
//  NeedFavorView.swift
//  The Favour
//
//  Created by Atta khan on 17/05/2023.
//

import SwiftUI

struct NeedFavorView: View {
    @State private var isNext = false
    @StateObject var viewModel = BookingViewModel()
    @State var detail: BookingData?
    @State private var bookingDetail = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack(spacing: 16) {
            if let result = viewModel.bookingFavor {
                topBarView
                if result.isEmpty {
                    Spacer()
                    FavorText(text: "No Favor found!", textColor: Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)), fontType: .bold, fontSize: 24, alignment: .leading, lineSpace: 0)
                    Spacer()
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(result.indices, id: \.self) { index in
                            NeedFavorCellView(bookingFavor: result[index]) {
                                viewModel.booking_data = result[index]
                                bookingDetail.toggle()
                            }
                            .padding(.vertical)
                        }
                    }
                }
            }
        }
        .padding()
        .navigationBarHidden(true)
        .navigationTitle("")
        .background( Color(#colorLiteral(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)))
        .spinner(isShowing: $viewModel.shouldShowLoader)
        .onAppear {
            viewModel.getFavorBooking()
        }
        .fullScreenCover(isPresented: $bookingDetail, content: {
            FavorBookingDetailView(booking_detail: viewModel.booking_data)
        })
    }
}

extension NeedFavorView {
    @ViewBuilder private var topBarView: some View {
        HStack(spacing: 12) {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image("ic_back")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            FavorText(text: "Favor Requester", textColor: Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)), fontType: .bold, fontSize: 22, alignment: .leading, lineSpace: 0)
            Spacer()
            FavorButton(text: "My Requests", width: 110, height: 30) {
                isNext = true
            }

        }
    }
}
