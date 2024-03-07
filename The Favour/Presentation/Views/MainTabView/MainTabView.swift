//
//  MainTabView.swift
//  The Favour
//
//  Created by Atta khan on 22/05/2023.
//

import SwiftUI

struct MainTabView: View {
    @State private var selection = 0
    @State var showingDetail = false

    @State private var home = UUID()
    @State private var favor = UUID()
    @State private var dashboard = UUID()
    @State private var help = UUID()
    @State private var profile = UUID()
    @State private var tappedTwice: Bool = false

    var handler: Binding<Int> { Binding(
        get: { self.selection },
        set: {
           if $0 == self.selection {
               tappedTwice = true
           }
           self.selection = $0
       }
   )}
    
    var body: some View {
        TabView(selection: handler) {
            HomeView()
                .onChange(of: tappedTwice, perform: { newValue in
                    guard newValue else { return }
                    home = UUID()
                    tappedTwice = false
                })
                .tabItem {
                    CustomTabItemView(imageName: "house.fill", title: "Home", isSelected: selection == 0)
                }
                .id(home)
                .tag(0)
            
            MainView()
                .onChange(of: tappedTwice, perform: { newValue in
                    guard newValue else { return }
                    favor = UUID()
                    tappedTwice = false
                })
                .tabItem {
                    CustomTabItemView(imageName: "suit.heart", title: "Favors", isSelected: selection == 1)
                }
                .id(favor)
                .tag(1)
            
            
            
            MyCustomFavorListView()
                
                .tabItem {
                    CustomTabItemView(imageName: "calendar.badge.plus", title: "Request", isSelected: selection == 1)
                    
                }
                .id(favor)
                .tag(2)
            
            SearchMapView()
                
                .tabItem {
                    CustomTabItemView(imageName: "map.fill", title: "Search", isSelected: selection == 1)
                    
                }
                .id(favor)
                .tag(3)
            
            
            ProfileView()
                .onChange(of: tappedTwice, perform: { newValue in
                    guard newValue else { return }
                    dashboard = UUID()
                    tappedTwice = false
                })
                .tabItem {
                    CustomTabItemView(imageName: "person", title: "Profile", isSelected: selection == 1)
                }
                .id(dashboard)
                .tag(4)
        }
        .accentColor(.appTitleColor)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}


struct CustomTabItemView: View {
    let imageName: String
    let title: String
    let isSelected: Bool
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
            Text(title)
        }
    }
}
