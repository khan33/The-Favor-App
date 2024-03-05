//
//  SearchFavorView.swift
//  The Favour
//
//  Created by Atta khan on 15/08/2023.
//

import SwiftUI

struct SearchFavorView: View {
    @StateObject var viewModel: FavorViewModel = FavorViewModel()
    @State private var searchText = ""
    @State private var favorDetail = false
    var body: some View {
        VStack(spacing: 16) {
            NavigationBarView(text: "Favor List") {
            }
            .padding(10)

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
        
        .onAppear {
            viewModel.getFavor()
        }

        .spinner(isShowing: $viewModel.shouldShowLoader)
    }
}

struct SearchFavorView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFavorView()
    }
}
