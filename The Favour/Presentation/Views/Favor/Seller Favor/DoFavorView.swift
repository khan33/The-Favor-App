//
//  DoFavorView.swift
//  The Favour
//
//  Created by Atta khan on 16/05/2023.
//

import SwiftUI

struct DoFavorView: View {
    @StateObject var viewModel: FavorViewModel
    var favor: FavorList?
    @State private var selectedItem: String?
    @State private var addPost = false

    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            NavigationLink(destination: PostFavorView(viewModel: viewModel), isActive: $addPost) { EmptyView() }

// MARK: - TITLE SECTION
            HStack {
                favor_title
                Spacer()
                more_view
            }
// MARK: - SERVICES & BOOKING INFO SECTION

            HStack {
                service_button
                
                Spacer()
                if favor?.favor_bookings ?? 0 > 0 {
                    booking_count_view
                }
                
                
            }
            
            HStack {
                rating_review_info
                Spacer()
                posted_time_info
            }
            .padding(.bottom, 8)

            
        }
        .padding(16)
        .background(Color(.white).cornerRadius(22))
        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)

        
    }
    
    func deleteItem(_ item: FavorList?) {
        guard let item = item else { return }
        viewModel.deleteFavor(id: item.id ?? 0)
    }

    func editItem(_ item: FavorList?) {
        guard let item = item else { return }
        
        
        viewModel.address = item.address ?? ""
        viewModel.title = item.title ?? ""
        viewModel.desc = item.meta_details?.description ?? ""
        viewModel.lat = item.lat ?? 0.0
        viewModel.lng = item.lng ?? 0.0
        viewModel.selectedService = ServiceModelData(id: item.category_id, name: item.category, color: nil, icon: nil, active: true, ispopular: true)
        
        viewModel.screenTitle = "Update a Favor"
        if item.media?.count ?? 0 > 0 {
            if let imgURL = item.media?[0].media_url {
                viewModel.loadImageFromURL(imageURLString: imgURL)
            }
        }
        viewModel.favor_id = String(item.id ?? 0)
        
        
        
        addPost = true
        
        
        
    }
    
    
    
    
}

extension DoFavorView {
    private var favor_title:some View {
        FavorText(text: favor?.title ?? "TI can do a car wash at your door step.", textColor: Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)), fontType: .bold, fontSize: 18, alignment: .leading, lineSpace: 0)
            .lineLimit(2)

    }
    
    
    private var more_view:some View {
        Image("more")
            .resizable()
            .scaledToFit()
            .frame(width: 16, height: 16)
            .contextMenu {
                Button(action: {
                    // Perform delete action
                    deleteItem(favor)
                }) {
                    Label("Delete", systemImage: "trash")
                }

                Button(action: {
                    // Perform edit action
                    editItem(favor)
                }) {
                    Label("Edit", systemImage: "pencil")
                }
            }
    }
    
    
    private var service_button: some View {
        FavorText(text: favor?.category ?? "", textColor: .appPrimaryColor, fontType: .regular, fontSize: 10, alignment: .center, lineSpace: 0)
            .padding(8)
            .background(Color(red: 0.945, green: 0.906, blue: 1))
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var booking_count_view: some View {
        ZStack(alignment: .center) {
            Circle()
                .fill(Color.appTitleColor)
                .frame(width: 24, height: 24)
                .overlay(
                    FavorText(text: String(favor?.favor_bookings ?? 0), textColor: .appWhite, fontType: .bold, fontSize: 11)
                        .minimumScaleFactor(0.5)
                )
        }
    }
    
    
    private var rating_review_info: some View {
        HStack {
            Image("Star")
            FavorText(text: String(favor?.avg_rating ?? 0), textColor: Color(#colorLiteral(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)), fontType: .medium, fontSize: 14, alignment: .leading, lineSpace: 0)
            FavorText(text: "| \(favor?.reviews?.count ?? 0) reviews", textColor: Color(#colorLiteral(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)), fontType: .medium, fontSize: 14, alignment: .leading, lineSpace: 0)
        }
    }
    
    private var posted_time_info: some View {
        FavorText(text: "Posted: \(UtilityManager.shared.getTimeAgoString(from: favor?.time_id ?? ""))", textColor: Color(#colorLiteral(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)), fontType: .medium, fontSize: 12, alignment: .leading, lineSpace: 0)

    }
    
}
