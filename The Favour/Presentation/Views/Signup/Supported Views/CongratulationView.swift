//
//  CongratulationView.swift
//  The Favour
//
//  Created by Atta khan on 26/04/2023.
//

import SwiftUI

struct CongratulationView: View {
    @Binding var show: Bool
    @State private var isNext = false

    var body: some View {
        ZStack {
            NavigationLink(destination: MainTabView(), isActive: $isNext) { EmptyView() }
            if show {
                Color.black.opacity(show ? 0.3 : 0).edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center, spacing: 20) {
                    
                    
                    Image("cong")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)
                        .padding(30)
                  
                    
                    FavorText(text: "Congratulations", textColor: .appTitleColor, fontType: .bold, fontSize: 24, alignment: .center)
                    
                    FavorText(text: "Your account is ready to use. You will be redirected to the Home page in a few seconds.", textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)), fontType: .regular, fontSize: 16, alignment: .center)
                    
                    FavorButton(text: "OK", width: .infinity, height: 60, bgColor: .appPrimaryColor) {
                        withAnimation(.linear(duration: 0.3)) {
                            show.toggle()
                            isNext = true
                        }
                    }
                    
                    
                    .padding(.all)
                }
                    .border(Color.white, width: 1)
                    .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .cornerRadius(16)
                    .padding()
            }
        }
    }
}

struct CongratulationView_Previews: PreviewProvider {
    static var previews: some View {
        CongratulationView(show: .constant(true))
    }
}
