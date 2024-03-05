//
//  SearchMapView.swift
//  The Favour
//
//  Created by Atta khan on 04/08/2023.
//

import SwiftUI

struct SearchMapView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var viewModel: FavorViewModel = FavorViewModel()
    @State private var selectedIndex: Int = 0
    @State var isPresented: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Group {
                    CustomNavigationBarView()
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            if let result = viewModel.popularServices {
                                ForEach(result.indices, id: \.self) { index in
                                    ServiceButtonView(text: result[index].name, textColor: index == selectedIndex ? .appWhite : .appPrimaryColor , bgColor: index == selectedIndex ? .appPrimaryColor : .appWhite) {
                                        selectedIndex = index
                                        viewModel.filterFavorbyService(service_id: result[index].id ?? 0)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(16)
                MapView(locationManager: locationManager, viewModel: viewModel, isPresented: $isPresented)
            }
            .onAppear {
              viewModel.getFavor()
            }
            .sheet(isPresented: $isPresented) {
                favor_detail
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
            }
            
        }
    }
    
    
    @ViewBuilder private var favor_detail: some View {
        VStack (spacing: 16){
            FavorText(text: "Favor Detail",
                      textColor: .appTitleBlack , fontType: .bold, fontSize: 20, alignment: .center, lineSpace: 0)
            .padding(.top, 20)
            FavorDividerView(width: .infinity, height: 1)
            ScrollView {
                VStack (spacing: 16){
                    
                    FavorInfoView(image: "", name: viewModel.favor_detail?.category ?? "", favTitle: viewModel.favor_detail?.title ?? "", rating: String(viewModel.favor_detail?.avg_rating ?? 0), totalReview: "|  \(viewModel.favor_detail?.reviews?.count ?? 0) reviews")
                    
                    HStack {
                        FavorButton(text: viewModel.favor_detail?.category ?? "", width: 90, height: 24, textColor: .appPrimaryColor, fontType: .regular, fontSize: 10,  bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
                        }
                        Spacer()
                        AddressView(address: viewModel.favor_detail?.address ?? "" )
                        
                    }
                    HStack(alignment: .top, spacing: 0) {
                        FavorText(text: "Posted: \(UtilityManager.shared.getTimeAgoString(from: viewModel.favor_detail?.time_id ?? ""))", textColor:  Color(red: 0.26, green: 0.26, blue: 0.26), fontType: .medium, fontSize: 14, alignment: .center, lineSpace: 0)
                        Spacer()
                    }
                    
                    FavorText(text: "Description", textColor:  .appBlack, fontType: .bold, fontSize: 20, alignment: .leading, lineSpace: 0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    FavorText(text: viewModel.favor_detail?.meta_details?.description ?? "", textColor:  .appTitleBlack, fontType: .regular, fontSize: 14, alignment: .leading, lineSpace: 0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            FavorDividerView(width: .infinity, height: 1)
            FavorButton(text: "Book Favor", width: .infinity, height: 55, bgColor: .appPrimaryColor) {
            }
            

        }
        .padding(.horizontal, 16)

    }
    
    
}

struct SearchMapView_Previews: PreviewProvider {
    static var previews: some View {
        SearchMapView()
    }
}


