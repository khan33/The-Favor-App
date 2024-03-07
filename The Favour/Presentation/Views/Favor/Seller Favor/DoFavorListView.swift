//
//  DoFavorListView.swift
//  The Favour
//
//  Created by Atta khan on 16/05/2023.
//

import SwiftUI

struct DoFavorListView: View {
    @State private var addPost = false
    @StateObject private var viewModel: FavorViewModel = FavorViewModel()
    @State private var favor_detail: FavorList?
    @State private var favorDetail = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack(spacing: 16) {
            NavigationLink(destination: PostFavorView(viewModel: viewModel), isActive: $addPost) { EmptyView() }
            topBarView
            if viewModel.favors?.count == 0 {
                Spacer()
                FavorText(text: "No Favor found!", textColor: Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)), fontType: .bold, fontSize: 24, alignment: .leading, lineSpace: 0)
                Spacer()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    if let favor = viewModel.favors {
                        ForEach(favor.indices, id: \.self) { index in
                            DoFavorView(viewModel: viewModel, favor: favor[index])
                                .onTapGesture {
                                    viewModel.favor_detail = favor[index]
                                    favorDetail = true
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
        .alert(isPresented: $viewModel.isAlertShow, content: {
            Alert(title: Text("Alert"),
                  message: Text(viewModel.alertMsg),
                  dismissButton: .default(Text("OK"), action: {
                    viewModel.getUserFavor()
            }))
        })
        .fullScreenCover(isPresented: $favorDetail) {
            if let detail = viewModel.favor_detail {
                FavorDetailView(isPresented: $favorDetail, favor_detail: detail, isBooking: true)
            }

        }
        .onAppear {
            viewModel.getUserFavor()
        }
        .spinner(isShowing: $viewModel.shouldShowLoader)
    }
}
extension DoFavorListView {
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
            FavorText(text: "Favor Provider", textColor: Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)), fontType: .bold, fontSize: 22, alignment: .leading, lineSpace: 0)
            
            Spacer()
            Image("add")
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
                .onTapGesture {
                    addPost = true
                }
        }
    }
}
