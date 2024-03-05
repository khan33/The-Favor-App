//
//  SettingMenuItem.swift
//  The Favour
//
//  Created by Atta khan on 26/04/2023.
//

import SwiftUI

struct SettingMenuItem: View {
    let title: String
    let image: String
    var isLogout: Bool = false
    var isAction:(() -> Void)? = nil
    
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)

            FavorText(text: title,
                      textColor: !isLogout ? Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)) : Color(#colorLiteral(red: 0.97, green: 0.33, blue: 0.33, alpha: 1)) , fontType: .semiBold, fontSize: 18, alignment: .center, lineSpace: 0)
                .padding(.leading, 20)
                .onTapGesture {
                    if isLogout {
                        isAction?()
                    }
                }
            Spacer()

            if !isLogout {
                
                Image(systemName: "chevron.right")
                    .padding(.trailing, 24)
                    .onTapGesture {
                        isAction?()
                    }
            }
        }
    }
}

struct SettingMenuItem_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            SettingMenuItem(title: "Home", image: "Home", isLogout: false)
            SettingMenuItem(title: "Edit Profile", image: "Profile", isLogout: false)

            SettingMenuItem(title: "Payment", image: "Wallet", isLogout: false)

            SettingMenuItem(title: "Security", image: "Shield Done", isLogout: false)

            SettingMenuItem(title: "Privacy Policy", image: "Lock", isLogout: false) {
                print("privacy policy")
            }
            
            SettingMenuItem(title: "Logout", image: "Logout", isLogout: true) {
            }
        }
    }
}
