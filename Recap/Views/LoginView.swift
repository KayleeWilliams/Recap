//
//  LoginView.swift
//  Recap
//
//  Created by Kaylee Williams on 30/11/2022.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authentication: AuthManager

    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            VStack {
                Image("Cover")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 400)
                    .padding(.bottom, 90)
                
                
                Button(action: {authentication.loginVisible.toggle()}, label: {
                    HStack {
                        Image("Spotify")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color("ButtonText"))
                        
                        Text("Connect Spotify")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color("ButtonText"))
                    }
                    .padding()
                    .background(Color("Button"))
                    .cornerRadius(10)
                }).sheet(isPresented: $authentication.loginVisible) {
                    WebView(url: authentication.authorizationURL, navigationController: UINavigationController())
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

