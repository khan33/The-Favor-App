//
//  PickLocationView.swift
//  The Favour
//
//  Created by Atta khan on 25/07/2023.
//

import SwiftUI

struct PickLocationView: View {
    @StateObject private var locationManager = LocationManager()
    @Binding var address: String
    @Binding var lat: Double
    @Binding var lng: Double
    @Binding var isPresented: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            NavigationBarView(text: "Your Address/Location")
                .padding(20)
            ZStack {
//                MapView(locationManager: locationManager, )
                MapView(locationManager: locationManager, viewModel: FavorViewModel(), isPresented: $isPresented)
                GeometryReader{ proxy in
                    VStack(spacing: 0) {
                        Spacer()
                        VStack {
                            VStack {
                                FavorDividerView(width: 44, height: 2)
                                    
                                FavorText(text: "Location Details", textColor: .black, fontType: .bold, fontSize: 20, alignment: .center, lineSpace: 0)
                                FavorDividerView(width: .infinity, height: 1)
                                    .padding(.horizontal, 12)
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            
                            Group {
                                FavorText(text: "Address", textColor: .black, fontType: .semiBold, fontSize: 16, alignment: .leading, lineSpace: 0)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                FavorTextField(placeholder: "Address", leftImage: nil, rightImage: "location", text: $locationManager.currentAddress)
                                
                                FavorButton(text: "Continue", width: .infinity, height: 55, bgColor: .appPrimaryColor) {
                                    address = locationManager.currentAddress
                                    lat = locationManager.latitude
                                    lng = locationManager.longitude
                                    isPresented = false
                                }
                                .padding(.top, 8)
                            }
                            .padding(.horizontal, 16)
                            Spacer()
                        }
                        .frame(height: proxy.size.height * 0.40)
                        .background(Color.white)
                        .cornerRadius(12)
                    }
                }
            }
        }
    }
}
