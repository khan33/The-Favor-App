//
//  AllServicesView.swift
//  The Favour
//
//  Created by Atta khan on 06/04/2023.
//

import SwiftUI

struct AllServicesView: View {
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @State private var selectedService: ServiceModelData?
    @State private var favorByService = false

    
    @StateObject var viewModel: FavorViewModel = FavorViewModel()
    
    var body: some View {
        VStack {
            if let service = selectedService {
                NavigationLink(destination: FavorByService(service: service, radius: viewModel.radius, searchText: ""), isActive: $favorByService) { EmptyView() }
            }
            NavigationBarView(text: "All Services")
            ScrollView(.vertical) {
                LazyVGrid(columns: gridItemLayout, spacing: 20) {
                    if let result = viewModel.services {
                        ForEach(result.indices, id: \.self) { index in
                            ServicesView(service: result[index]) {
                                selectedService = result[index]
                                viewModel.filterFavorbyService(service_id: result[index].id ?? 0)
                                favorByService.toggle()
                            }

                        }
                    }
                }
            }
            .padding(.top, 20)
        }
        .padding(24)
        .navigationBarHidden(true)
        .navigationTitle("")
        .spinner(isShowing: $viewModel.shouldShowLoader)
        .onAppear {
            viewModel.getService()
        }

    }
}

struct AllServicesView_Previews: PreviewProvider {
    static var previews: some View {
        let service: [ServiceModelData] = []
        AllServicesView()
    }
}
