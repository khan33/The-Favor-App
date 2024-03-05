//
//  RequestView.swift
//  The Favour
//
//  Created by Atta khan on 16/05/2023.
//

import SwiftUI
import CoreLocation

struct RequestView: View {
    @State private var isExpandable = false
    @StateObject var locationManager: LocationManager = LocationManager()
    var distance: CLLocationDistance = 0.0
//    @ObservedObject var viewModel: BookingViewModel
    var booking_data: BookingData
    var action: (() -> Void)? = nil
    //let updateButtonState: () -> Void

    
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

    var body: some View {
        
        VStack(alignment: .leading, spacing: 24) {
            ZStack {
                RoundedRectangle(cornerRadius: 32)
                    .foregroundColor(.appWhite)
                VStack (alignment: .leading) {
                    HStack (alignment: .top, spacing: 0) {
                        if let image = booking_data.profile_photo, image != "" {
                            AsyncImage(url: URL(string: image)!) { img in
                                img
                                    .resizable()
                                    .frame(width: 48, height: 48)
                                    .clipShape(Circle())
                                    .padding([.leading, .vertical])
                            } placeholder: {
                                Image("user_profile")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 48, height: 48)
                                    .padding([.leading, .vertical])
                            }
                            
                            
                        } else {
                            Image("user_profile")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48, height: 48)
                                .padding([.leading, .vertical])
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            FavorText(text: booking_data.user_name ?? "" , textColor: .appBlack, fontType: .bold, fontSize: 16, alignment: .center, lineSpace: 0)
                                .padding(.bottom, 8)
                            HStack {
                                
                                Image("Star")
                                
                                FavorText(text: "4.8", textColor: Color(#colorLiteral(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)), fontType: .medium, fontSize: 14, alignment: .leading, lineSpace: 0)
                                FavorText(text: "| 8.889 reviews", textColor: Color(#colorLiteral(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)), fontType: .medium, fontSize: 14, alignment: .leading, lineSpace: 0)
                            }
                            
                        }
                        .padding(12)

                    }
                    .padding(.top, 24)
                    FavorText(text: "$\(String(describing: booking_data.total_price ?? 0))", textColor: Color(#colorLiteral(red: 0.43, green: 0.23, blue: 0.73, alpha: 1)), fontType: .bold, fontSize: 24, alignment: .leading, lineSpace: 0)
                        .padding(.leading, 70)
                    
                    HStack {
                        FavorButton(text: UtilityManager.shared.buttonText(for: booking_data.status ?? .pending), width: .infinity, height: 50, textColor: UtilityManager.shared.buttonColor(for: booking_data.status ?? .pending), bgColor: .appWhite) {
                        }
                        .border(UtilityManager.shared.buttonColor(for: booking_data.status ?? .pending), width: 0.5, cornerRadius: 24)
                    }
                    .padding(.horizontal, 24)
                    FavorDividerView(width: .infinity, height: 0.5)
                    if isExpandable { requestExpandInfoView }
                    
                    HStack {
                        Spacer()
                        upDownIcon
//                            .onTapGesture {
//                                isExpandable.toggle()
//                            }
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    
                    
                    Spacer()
                }
                
            }
            .frame(width: .infinity, height: isExpandable ? 420 : 300)
            
        }
        .onAppear {
            locationManager.startUpdatingLocation()
        }
        .onDisappear {
            locationManager.stopUpdatingLocation()
        }
        .onTapGesture {
            action?()
        }
    }
    

    
    
    private var upDownIcon: some View {
        Image(systemName: isExpandable ? "chevron.right" : "chevron.right")
            .resizable()
            .scaledToFit()
            .frame(width: 16, height: 16)
            .foregroundColor(isExpandable ? .appLightBlack : .appBlack)
    }
    
    private var requestExpandInfoView: some View {
        VStack(spacing: 16) {
            HorizontalTwoLabelView(label1: "Date & Time", label2: "\(booking_data.favor_date ?? "") \(booking_data.favor_time ?? "")", fontTypeLbl1: .medium, fontSizeLbl1: 14,  fontTypeLbl2: .semiBold, fontSizeLbl2: 16)
            HorizontalTwoLabelView(label1: "Location", label2: booking_data.address ?? "", fontTypeLbl1: .medium, fontSizeLbl1: 14, fontTypeLbl2: .semiBold, fontSizeLbl2: 16)
            HorizontalTwoLabelView(label1: "Distance", label2: "\(calculateDistance(to: CLLocation(latitude: booking_data.lat ?? 0.0, longitude: booking_data.lng ?? 0.0))) miles away", fontTypeLbl1: .medium, fontSizeLbl1: 14, fontTypeLbl2: .semiBold, fontSizeLbl2: 16)
        }
        .padding(.horizontal, 16)
    }
}
