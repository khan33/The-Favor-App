//
//  FavorByService.swift
//  The Favour
//
//  Created by Atta khan on 12/05/2023.
//

import SwiftUI

struct FavorByService: View {
    @State private var favorDetail = false

    var service: ServiceModelData?
    var radius: String
    @State var searchText: String

    @StateObject var viewModel: FavorViewModel = FavorViewModel()

    init(service: ServiceModelData?, radius: String, searchText: String) {
        self.service = service
        self.radius = radius
        self.searchText = searchText
    }
    
    var body: some View {
        VStack(spacing: 16) {
            NavigationBarView(text: service?.name ?? "Favor Searching...") {
            }
            .padding(10)

            
            SearchBarView(searchText: $searchText) {
            }
            
            ScrollView (showsIndicators: false) {
                if let favor = viewModel.favorsByService {
                    if favor.isEmpty {
                        FavorText(text: "No Record Found!", textColor: .red, fontType: .regular, fontSize: 9, alignment: .center, lineSpace: 0)
                            .padding(.horizontal, 8)
                    } else {
                        ForEach(favor.indices, id: \.self) { index in
                            FavorListView(favor: favor[index]) {
                                viewModel.favor_detail = favor[index]
                                favorDetail.toggle()
                            }
                        }
                    }
                }
                
            }
            
        }
        .padding(.horizontal, 20)
        .navigationBarHidden(true)
        .navigationTitle("")
        .fullScreenCover(isPresented: $favorDetail, content: {
            if let detail = viewModel.favor_detail {
                FavorDetailView(isPresented: $favorDetail, favor_detail: detail, isBooking: false)
            }
        })
        .onAppear {
        }
        .onChange(of: viewModel.locationManager.location, perform: { newValue in
            viewModel.category_id = "0"
            if searchText == "" {
                viewModel.category_id = String(self.service?.id ?? 0)
            }
            viewModel.is_services = "false"
            viewModel.page_size = "20"
            viewModel.search_keyword = searchText
            viewModel.radius = radius
            viewModel.getFavor()
        })

        .spinner(isShowing: $viewModel.shouldShowLoader)

    }
}
