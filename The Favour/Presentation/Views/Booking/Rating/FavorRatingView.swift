//
//  RatingView.swift
//  The Favour
//
//  Created by Atta khan on 05/08/2023.
//

import SwiftUI

struct FavorRatingView: View {
    @Binding var show: Bool
    @State var review: String = ""
    @State var rating: Int = 0
    @ObservedObject var viewModel: BookingViewModel
    var bookingId: String
    var body: some View {
        ZStack {
            if show {
                Color.black.opacity(show ? 0.5 : 0).edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        show.toggle()
                    }
                VStack(alignment: .center, spacing: 20) {
                    Image("RatingIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)
                        .padding(30)
                    
                    FavorText(text: "Rate this favor", textColor: .appTitleColor, fontType: .bold, fontSize: 24, alignment: .center)
                    
                    
                    FavorText(text: "Please do it promptly so the person get paid", textColor: Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)), fontType: .regular, fontSize: 16, alignment: .center)
                    
                    
                    HStack(alignment: .center) {
                        ForEach(1...5, id: \.self) { index in
                            Image(systemName: self.starType(for: index))
                                .frame(width: 14, height: 14)
                                .padding(.vertical, 8)
                                .padding(.leading, 14)
                                .foregroundColor(index <= self.rating ? .yellow : .gray)
                                .onTapGesture {
                                    self.rating = index
                                }

                        }
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.appTextFieldColor)
                            .frame(height: 100)
                            .border(.appWhite, width: 1, cornerRadius: 12)
                        
                            TextViewWrapper(text: $review)
                                .padding(8)
                                .frame(height: 100)
                                .cornerRadius(8)
                           
                        }
                    .padding(.horizontal, 24)

                    
                    
                    FavorButton(text: "SUBMIT", width: .infinity, height: 60, bgColor: .appPrimaryColor) {
                        viewModel.addRatingToFavor(bookingId: bookingId, comments: review, rating: String(rating))
                    }
                    .padding(.horizontal, 24)

                    
                    FavorButton(text: "Report this favor", width: .infinity, height: 60, textColor: Color.red, bgColor: .white) {
                        withAnimation(.linear(duration: 0.3)) {
                        }

                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
                   
                }
                .border(Color.white, width: 1)
                .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                .cornerRadius(16)
                .padding()
            }
        }
    }
    
    private func starType(for index: Int) -> String {
        return index <= rating ? "star.fill" : "star"
    }
}
