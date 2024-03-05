//
//  AlertView.swift
//  The Favour
//
//  Created by Atta khan on 28/04/2023.
//

import SwiftUI

struct AlertView: View {
    var body: some View {
        VStack (alignment: .leading){
            NavigationBarView(text: "Alerts")
            
            FavorText(text: "Today",
                      textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)) , fontType: .bold, fontSize: 18, alignment: .leading, lineSpace: 0)
            .padding(.vertical)
            
            AlertCardView(image: "favor_accept", timeStr: "3 min ago", title: "Alex Accepted Your Favor", desc: "Lorem ipsum dolor sit amet, consect.....")
            
            AlertCardView(image: "favor_reject", timeStr: "3 min ago", title: "Alex Accepted Your Favor", desc: "Lorem ipsum dolor sit amet, consect.....")
            
            FavorText(text: "March 11, 2024",
                      textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)) , fontType: .bold, fontSize: 18, alignment: .leading, lineSpace: 0)
            .padding(.vertical)

            AlertCardView(image: "favor_accept", timeStr: "3 min ago", title: "Alex Accepted Your Favor", desc: "Lorem ipsum dolor sit amet, consect.....")
            
            AlertCardView(image: "favor_reject", timeStr: "3 min ago", title: "Alex Accepted Your Favor", desc: "Lorem ipsum dolor sit amet, consect.....")

        }
        .padding(24)
        .navigationBarHidden(true)
        .navigationTitle("")
    }
       
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView()
    }
}
