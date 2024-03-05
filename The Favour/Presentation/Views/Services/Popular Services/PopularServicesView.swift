//
//  PopularServicesView.swift
//  The Favour
//
//  Created by Atta khan on 10/05/2023.
//

import SwiftUI

struct PopularServicesView: View {
    @State private var searchText = ""
    @State private var favorDetail = false
    @State private var selectedIndex: Int = 0

    @ObservedObject var viewModel: FavorViewModel
    
    init(viewModel: FavorViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 16) {
            NavigationBarView(text: "Most Popular Services")
                .padding(10)
            SearchBarView(searchText: $searchText) {
            }
            
                
            
            
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

            
            ScrollView(showsIndicators: false){
                
                if let favor = viewModel.popularServicFavors {
                    if favor.isEmpty {
                        FavorText(text: "No favor available right now!", textColor: .red, fontType: .regular, fontSize: 9, alignment: .center, lineSpace: 0)
                            .padding(.horizontal, 8)
                    } else {
                        ForEach(favor.indices.prefix(6), id: \.self) { index in
                            FavorListView(favor: favor[index]) {
                                viewModel.favor_detail = favor[index]
                                favorDetail.toggle()
                            }
                        }
                    }
                }
                
//                FavorServicesView(image: "fav_cleaning", name: "Kylee Danford", favTitle: "House Cleaning", rating: "4.8", totalReview: "8.889 reviews",service: ["Cleaning", "Repairing", "Painting"]) {
//                    favorDetail.toggle()
//                }
//
//
//                FavorServicesView(image: "fav_cleaning", name: "Kylee Danford", favTitle: "House Cleaning", rating: "4.8", totalReview: "8.889 reviews",service: ["Cleaning", "Repairing", "Painting"]) {
//                    favorDetail.toggle()
//                }
            }
        }
        .padding(20)
        .navigationBarHidden(true)
        .navigationTitle("")
        .fullScreenCover(isPresented: $favorDetail, content: {
            if let detail = viewModel.favor_detail {
                FavorDetailView(isPresented: $favorDetail, favor_detail: detail, isBooking: false)
            }
        })
        
    }
}

struct PopularServicesView_Previews: PreviewProvider {
    static var previews: some View {
        PopularServicesView(viewModel: FavorViewModel())
    }
}
