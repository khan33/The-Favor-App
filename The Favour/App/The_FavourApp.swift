//
//  The_FavourApp.swift
//  The Favour
//
//  Created by Atta khan on 05/04/2023.
//

import SwiftUI

@main
struct The_FavourApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var userViewModel = UserModeViewModel()

    var body: some Scene {
        WindowGroup {
//            ExampleView()
            if PrefsManager.shared.isWalkThrough {
                if KeychainManager.getAuthToken() != nil{
                    MainTabView()
                        .environmentObject(userViewModel)
                } else {
                    NavigationView {
                        SignupView()
                            .environmentObject(userViewModel)

                    }
                }
            } else {
                SplashScreenView()
                    .environmentObject(userViewModel)

            }
        }

    }
}