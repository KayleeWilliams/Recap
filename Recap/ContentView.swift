//
//  ContentView.swift
//  Recap
//
//  Created by Kaylee Williams on 30/11/2022.
//

import SwiftUI
let clientID = "09b5f29ff349407d8f16aad612e032cd"
let redirectURI = "https://www.kayleewilliams.dev"
let scopes = "user-top-read"
let responseType = "code"



struct ContentView: View {
    @State public var showLogin = false
//    private let loginURL: String = "https://kayleewilliams.dev1"
    private let loginURL: String = "https://accounts.spotify.com/authorize?client_id=\(clientID)&response_type=\(responseType)&scopes=\(scopes)&redirect_uri=\(redirectURI)"

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
                

                Button(action: {showLogin.toggle()}, label: {
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
                }).sheet(isPresented: $showLogin) {
                    WebView(url: URL(string: loginURL))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

