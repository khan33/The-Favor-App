//
//  MainView.swift
//  The Favour
//
//  Created by Atta khan on 16/04/2023.
//

import SwiftUI


enum FavorType: String{
    case needFavor = "favor_buyer" //"Need a favor"
    case canDoFavor = "favor_seller" //"can do you a favor"
}

struct MainView: View {
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isMainView = false
//    @StateObject var viewModel: AthenticationViewModel = AthenticationViewModel()
    
//    let new_register: Bool
    
    @State private var needFaor = false
    @State private var canDoFavor = false

    
    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                NavigationLink(destination: NeedFavorView(), isActive: $needFaor) { EmptyView() }
                NavigationLink(destination: DoFavorListView(), isActive: $canDoFavor) { EmptyView() }
                
                FavorText(text: "Select Favor Type", textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)), fontType: .bold, fontSize: 24, alignment: .leading, lineSpace: 0)
                    .padding(24)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                FavorCardView(title: "FAVOR REQUESTER", subTitle: "Get you work done in a quick way. We are here for your help.", imageName: "need_favor_2", gradientColor: Gradient(stops: [
                    .init(color: Color(#colorLiteral(red: 0.6509804129600525, green: 0.3176470696926117, blue: 0.8196078538894653, alpha: 1)), location: 0),
                    .init(color: Color(#colorLiteral(red: 0.6165271997451782, green: 0.3500000238418579, blue: 1, alpha: 1)), location: 1)])) {
                        needFaor = true
                        
                    }
                    .padding(.top, 24)
                    .padding(.horizontal)
                
                FavorCardView(title: "FAVOR PROVIDER", subTitle: "Get discount for every order, only valid for today", imageName: "can_do_favor_2", gradientColor: Gradient(stops: [
                    .init(color: Color(#colorLiteral(red: 0.13333334028720856, green: 0.7333333492279053, blue: 0.6117647290229797, alpha: 1)), location: 0),
                    .init(color: Color(#colorLiteral(red: 0.20682293176651, green: 0.8708333373069763, blue: 0.7362953424453735, alpha: 1)), location: 1)])) {
                        canDoFavor = true
                    }
                    .padding(.horizontal)

                
                Spacer()
            }
            
            .background(Color.white)
            .navigationBarBackButtonHidden(true)
        }
    }

}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
