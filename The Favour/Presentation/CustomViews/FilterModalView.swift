//
//  FilterModalView.swift
//  The Favour
//
//  Created by Atta khan on 21/05/2023.
//

import SwiftUI

struct FilterModalView: View {
    @Binding var isShowing: Bool
    @Binding var services: [String]
    
    @State private var curHeight: CGFloat = 600
    let maxHeight: CGFloat = 700
    let minHeight: CGFloat = 400
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isShowing {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                    }
                mainView
                    .transition(.move(edge: .bottom))
            }
        }
        .frame(width: .infinity, height: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut)
    }
    
    
    var mainView: some View {
        VStack {
            ZStack {
                Capsule()
                    .frame(width: 40, height: 5)
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.00001))
            
            
            
            ZStack {
                VStack(alignment: .leading, spacing: 16) {
                    FavorText(text: "Filter",
                              textColor: .appTitleBlack , fontType: .bold, fontSize: 24, alignment: .center, lineSpace: 0)
                    .frame(maxWidth: .infinity)
                    FavorDividerView(width: .infinity, height: 1)

                    //DistanceSliderView(minValue: 0, maxValue: 100, step: 1, title: "Location")
                    
                    FavorText(text: "Category",
                              textColor: .appTitleBlack , fontType: .bold, fontSize: 20, alignment: .center, lineSpace: 0)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0..<services.count) { index in
                                ServiceButtonView(text: services[index], textColor: index == 0 ? .appWhite : .appPrimaryColor , bgColor: index == 0 ? .appPrimaryColor : .appWhite) {
                                }
                            }
                        }
                    }
                    .padding(.vertical, 16)
                    
                    FavorText(text: "Favor Type",
                              textColor: .appTitleBlack , fontType: .bold, fontSize: 20, alignment: .center, lineSpace: 0)
                    HStack {
                        FavorButton(text: "Part Time", width: .infinity, height: 44, textColor: .appPrimaryColor, bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
                        }
                        FavorButton(text: "Full Time", width: .infinity, height: 44, bgColor: .appPrimaryColor) {

                        }

                    }
                    
                    FavorDividerView(width: .infinity, height: 1)
                    HStack {
                        FavorButton(text: "Rest", width: .infinity, height: 60, textColor: .appPrimaryColor, bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
                        }
                        FavorButton(text: "Filter", width: .infinity, height: 60, bgColor: .appPrimaryColor) {
                            
                        }
                        
                    }
                }
                .padding(24)

            }
            .frame(maxHeight: .infinity)
//            .padding(.bottom, 35)

        }
        .frame(height: curHeight)
        .frame(maxWidth: .infinity)
        .background (
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                Rectangle()
                    .frame(height: curHeight / 2)
            }
                .foregroundColor(Color.white)
        )
    }
}

struct FilterModalView_Previews: PreviewProvider {
    static var previews: some View {
        //FilterModalView(isShowing: .constant(true))
        HomeView()
    }
}
