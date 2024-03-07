//
//  MyCustomFavorListView.swift
//  The Favour
//
//  Created by Atta khan on 15/08/2023.
//

import SwiftUI

struct MyCustomFavorListView: View {
    @State private var addPost = false
    @StateObject private var viewModel: FavorViewModel = FavorViewModel()
    @State private var favorDetail = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                NavigationLink(destination: PostFavorView(viewModel: viewModel), isActive: $addPost) { EmptyView() }
                topBarView
                    .padding(.horizontal)
                
                VStack {
                    if viewModel.customFavor?.count == 0 {
                        Spacer()
                        FavorText(text: "No Favor found!", textColor: Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)), fontType: .bold, fontSize: 24, alignment: .leading, lineSpace: 0)
                        Spacer()
                        
                    } else {
                        ScrollView(.vertical, showsIndicators: false) {
                            if let favor = viewModel.customFavor {
                                ForEach(favor.indices, id: \.self) { index in
                                    DoFavorView(viewModel: viewModel, favor: favor[index])
                                        .onTapGesture {
                                            viewModel.favor_detail = favor[index]
                                            favorDetail = true
                                        }
                                }
                            }
                        }
                    }
                }
                .padding(24)
            }
            .navigationBarHidden(true)
            .navigationTitle("")
            .background( Color(#colorLiteral(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)))
            .alert(isPresented: $viewModel.isAlertShow, content: {
                Alert(title: Text("Alert"),
                      message: Text(viewModel.alertMsg),
                      dismissButton: .default(Text("OK"), action: {
                    viewModel.getCustomFavor()
                }))
            })
            .fullScreenCover(isPresented: $favorDetail) {
                if let detail = viewModel.favor_detail {
                    FavorDetailView(isPresented: $favorDetail, favor_detail: detail, isBooking: true)
                }
                
            }
            .onAppear {
                viewModel.getCustomFavor()
            }
            .spinner(isShowing: $viewModel.shouldShowLoader)
        }
    }
    @ViewBuilder private var topBarView: some View {
        HStack(spacing: 12) {
            FavorText(text: "My Request Favor", textColor: Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)), fontType: .bold, fontSize: 24, alignment: .leading, lineSpace: 0)
            Spacer()
            Image("add")
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
                .onTapGesture {
                    addPost = true
                    viewModel.isCustomFavor = true
                }
        }
    }}

struct MyCustomFavorListView_Previews: PreviewProvider {
    static var previews: some View {
        MyCustomFavorListView()
    }
}
