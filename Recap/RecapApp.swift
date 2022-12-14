//
//  RecapApp.swift
//  Recap
//
//  Created by Kaylee Williams on 30/11/2022.
//

import SwiftUI
import KeychainAccess

@main
struct RecapApp: App {
    @StateObject var authentication = AuthManager()
    @StateObject var apiManager = APIManager()
    @State private var splashVisible = true
    var body: some Scene {
        WindowGroup {
            if splashVisible {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            splashVisible = false
                        }
                    }
            } else {
                
                if authentication.isValidated == false {
                    LoginView()
                        .environmentObject(authentication)
                }
                else {
                    PageView()
                        .environmentObject(authentication)
                        .environmentObject(apiManager)
                }
            }
        }
    }
}
