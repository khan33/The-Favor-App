//
//  FavorDetailView.swift
//  The Favour
//
//  Created by Atta khan on 12/05/2023.
//

import SwiftUI

struct FavorDetailView: View {
    @State private var searchText = ""
    @State private var isExpanded = false
    @State private var isNext = false
    
    @Binding var isPresented: Bool
    var favor_detail: FavorList?
    @State var isBooking: Bool
    @State var isRequestScreen: Bool = false
    @State private var selectedIndex: Int = 0
    @State var isChatview: Bool = false

    var body: some View {
        NavigationView {
            
            VStack(alignment: .leading) {
                NavigationLink(destination: BookingView(favor_id: favor_detail?.id ?? 0), isActive: $isNext) { EmptyView() }
                NavigationLink(destination: MyRequestView(favor_id: favor_detail?.id ?? 0), isActive: $isRequestScreen) { EmptyView() }
                NavigationLink(destination: ChatView(chat: Chat.sampleChat[0]), isActive: $isChatview) { EmptyView() }

                
                VStack(spacing: 16) {
                    NavigationBarView(text: "Detail") {
                        self.isPresented.toggle()
                    }
                    
                    ScrollView (showsIndicators: false) {
                        favorHeaderInfo
                        FavorDividerView(width: .infinity, height: 0.5)
                        favorPostedInfo
                        favorDesc
                        FavorDividerView(width: .infinity, height: 0.5)
                        
                        if favor_detail?.reviews?.count ?? 0 > 0 {
                            favorRatingTitle
                            favorRatingButtons
                            ForEach((favor_detail?.reviews!.indices)!, id: \.self) { index in
                                RatingView(review: favor_detail?.reviews?[index])
                            }
                            
                        }
                    }
                }
                .padding([.horizontal, .top], 20)
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
                        if isBooking == false {
                            FavorButton(text: "Message", width: .infinity, height: 55, textColor: .appPrimaryColor, bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
                                isChatview.toggle()
                            }
                            FavorButton(text: "Book Favor", width: .infinity, height: 55, bgColor: .appPrimaryColor) {
                                isNext = true
                            }
                        } else {
                            ZStack(alignment: .trailing) {
                                FavorButton(text: "View Request", width: .infinity, height: 55, bgColor: .appPrimaryColor) {
                                    isRequestScreen = true
                                }
                                if favor_detail?.favor_bookings ?? 0 > 0 {
                                    booking_count
                                        .padding(.trailing, 10)
                                }
                            }
                            
                            
                            
                        }
                    }
                    .padding(.horizontal, 24)
                }
                
            }
            .navigationBarHidden(true) // Hide the navigation bar on this screen
            .navigationTitle("")
            .edgesIgnoringSafeArea(.bottom)
            .onAppear {
                print(favor_detail)
            }
        }
    }
    private func createTopRoundedMask(cornerRadius: CGFloat, height: CGFloat) -> some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: height))
            path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: height))
            path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 0))
            path.addArc(center: CGPoint(x: UIScreen.main.bounds.width - cornerRadius, y: cornerRadius),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: -90),
                        endAngle: Angle(degrees: 0),
                        clockwise: false)
            path.addArc(center: CGPoint(x: cornerRadius, y: cornerRadius),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 180),
                        endAngle: Angle(degrees: 90),
                        clockwise: false)
        }
    }
    
}

extension FavorDetailView {
    @ViewBuilder private var booking_count: some View {
        ZStack {
            Circle()
                .fill(Color.white)
            .frame(width: 24, height: 24)
            FavorText(text: "\(favor_detail?.favor_bookings ?? 0)", textColor:  .appPrimaryColor, fontType: .regular, fontSize: 11, alignment: .leading, lineSpace: 0)

        }
    }
    
    
    @ViewBuilder private var favorPostedInfo: some View {
        HStack(alignment: .top, spacing: 0) {
            FavorText(text: "Posted: \(UtilityManager.shared.getTimeAgoString(from: favor_detail?.time_id ?? ""))", textColor:  Color(red: 0.26, green: 0.26, blue: 0.26), fontType: .medium, fontSize: 14, alignment: .center, lineSpace: 0)
            Spacer()
//            AddressView(address: favor_detail?.address ?? "" )
        }
    }
    @ViewBuilder private var favorDesc: some View {
        HStack {
            FavorText(text: "Description", textColor:  .appBlack, fontType: .bold, fontSize: 20, alignment: .leading, lineSpace: 0)
            Spacer()
        }
        .padding(.vertical, 12)
        
        
        FavorText(text: favor_detail?.meta_details?.description ?? "", textColor:  .appTitleBlack, fontType: .regular, fontSize: 14, alignment: .leading, lineSpace: 0)
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(isExpanded ? nil : 3)
            .animation(.easeInOut)
            .overlay(
                    GeometryReader { proxy in
                        Button(action: {
                            isExpanded.toggle()
                        }) {
                            if favor_detail?.meta_details?.description?.count ?? 0 > 40 {
                                Text(isExpanded ? "Less" : "More")
                                    .font(.caption).bold()
                                    .padding(.leading, 8.0)
                                    .padding(.top, 4.0)
                                    .background(Color.white)
                            }
                        }
                        .frame(width: proxy.size.width, height: proxy.size.height, alignment: .bottomTrailing)
                    }
                )
    }
    
    @ViewBuilder private var favorRatingButtons: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach((0..<6), id: \.self) { index in
                    RatingStarButtonView(text: index == 0 ? "All" : String(6 - index), textColor: index == selectedIndex ? .white : .appPrimaryColor, fontType: .semiBold, fontSize: 14, bgColor: index == selectedIndex ? .appPrimaryColor : .white) {
                        selectedIndex = index
                    }
                }
            }
        }
        .padding(.vertical, 16)
    }
    @ViewBuilder private var favorRatingTitle: some View {
        HStack {
            Image("Star")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
            SeeAllView(label1: "\(String(describing: favor_detail?.avg_rating ?? 0)) (\(String(describing: favor_detail?.reviews?.count ?? 0)) reviews)", label2: "")
        }
        .padding(.top, 0)
    }
    
    @ViewBuilder private var favorHeaderInfo: some View {
        FavorInfoView(image: "", name: favor_detail?.category ?? "", favTitle: favor_detail?.title ?? "", rating: String(favor_detail?.avg_rating ?? 0), totalReview: "| \(favor_detail?.reviews?.count ?? 0) reivews")
        
        HStack {
            FavorText(text: favor_detail?.category ?? "", textColor: .appPrimaryColor, fontType: .regular, fontSize: 10, alignment: .center, lineSpace: 0)
                .padding(8)
                .background(Color(red: 0.945, green: 0.906, blue: 1))
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
            AddressView(address: favor_detail?.address ?? "" )
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}
