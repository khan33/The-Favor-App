//
//  PopupView.swift
//  The Favour
//
//  Created by Atta khan on 05/08/2023.
//

import SwiftUI

struct PopupView: View {
    @Binding var show: Bool
    var message: String = "Congratulations"
    var messaeg_detail: String = ""
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
                        .frame(width: 120, height: 120)
                        .padding(30)
                    Group {
                        FavorText(text: message, textColor: .appTitleColor, fontType: .bold, fontSize: 24, alignment: .center)
                        FavorText(text: messaeg_detail, textColor: Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)), fontType: .regular, fontSize: 16, alignment: .center)
                    }
                    .padding(.horizontal)
                    
                    FavorButton(text: "OK", width: .infinity, height: 60, bgColor: .appPrimaryColor) {
                        show.toggle()
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
}

struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        PopupView(show: .constant(true))
    }
}
