//
//  PrivacyPolicyView.swift
//  The Favour
//
//  Created by Atta khan on 27/04/2023.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                NavigationBarView(text: "Privacy Policy")
                FavorText(text: "1. Privacy Policy", textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)), fontType: .bold, fontSize: 20, alignment: .center, lineSpace: 0)
                    .padding(.top, 24)
                
                FavorText(text: "We at Favor want you to understand what information we collect and how we use and share it.All personal information collected is solely for the protection of all Favor’s users. This information will help us provide a more personalized experience for you. In order to gain the full Favor experience, the required information is necessary. Without it, the quality of your experience may be affected. With the information provided, all Favor providers will undergo a limited background check to ensure the safety of all users.", textColor: Color(#colorLiteral(red: 0.26, green: 0.26, blue: 0.26, alpha: 1)), fontType: .regular, fontSize: 14, alignment: .leading, lineSpace: 0)
                
                FavorText(text: "2. Liability", textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)), fontType: .bold, fontSize: 20, alignment: .center, lineSpace: 0)
                
                FavorText(text: "The Favor App bears no responsibility for any damages or injures that occur from the fulfillment  of a request. It is the responsibility of the Favor requestor to vet all possible candidates for the job prior to the start. It is the responsibility of the Favor provider to take all necessary precautions when fulfilling a favor. The Favor App is solely providing a service where two independent parties can agree upon pricing and terms without any input from the Favor App. Favor providers are independent contractors providing services for rates determined by the market.", textColor: Color(#colorLiteral(red: 0.26, green: 0.26, blue: 0.26, alpha: 1)), fontType: .regular, fontSize: 14, alignment: .leading, lineSpace: 0)
                
                
                
                FavorText(text: "3. Terms of Service", textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)), fontType: .bold, fontSize: 20, alignment: .center, lineSpace: 0)
                
                FavorText(text: "The Favor App is designed to act as a link for individuals seeking services and those willing to fulfill those services at a price determined by the market. The skillsets of those individuals fulfilling services can range from casual to professional, freelance to contractual. It is the responsibility of the favor requestor to vet skillsets when choosing someone to fulfill a service. It is our hope that The Favor App becomes a means in which once can sustain themselves and create a solid foundation for their futures. /n Although The Favor App is free to use, we do collect a 10% administration fee from each transaction completed through the Favor Apps portal. We will not sell to or use your personal data with advertisers. We will not share any information that directly identifies you with advertisers unless we have received your direct permission.", textColor: Color(#colorLiteral(red: 0.26, green: 0.26, blue: 0.26, alpha: 1)), fontType: .regular, fontSize: 14, alignment: .leading, lineSpace: 0.2)
            }
            .padding(.horizontal, 24)
            .navigationBarHidden(true)
            .navigationTitle("")
        }
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
