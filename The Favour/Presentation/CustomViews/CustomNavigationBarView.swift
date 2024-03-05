//
//  CustomNavigationBarView.swift
//  The Favour
//
//  Created by Atta khan on 08/05/2023.
//

import SwiftUI

struct CustomNavigationBarView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var user: User?

    var body: some View {
        HStack(spacing: 12) {
            if let img = user?.profile_photo, img != "" {
                AsyncImage(url: URL(string: img)!) { img in
                    img
                        .resizable()
                        .frame(width: 48, height: 48)
                        .clipShape(Circle())
                } placeholder: {
                    Image("user_profile")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                        .padding(.leading, 8)
                }
                
                
            } else {
                Image("user_profile")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                    .padding(.leading, 8)
            }

            
            
            VStack(alignment: .leading) {
                FavorText(text: "Good Morning 👋", textColor: Color(#colorLiteral(red: 0.46, green: 0.46, blue: 0.46, alpha: 1)), fontType: .medium, fontSize: 16, alignment: .leading, lineSpace: 0)
                FavorText(text: user?.name ?? "", textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)), fontType: .medium, fontSize: 20, alignment: .leading, lineSpace: 0)
            }
            Spacer()
            Image("notification")
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
        }
        .onAppear {
            let decoder = JSONDecoder()
            if let data = UserDefaults.standard.data(forKey: "currentUser"),
               let storedUser = try? decoder.decode(User.self, from: data) {
                self.user = storedUser
            }
        }
        
    }
}

struct CustomNavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationBarView()
    }
}
