//
//  PageView.swift
//  Recap
//
//  Created by Kaylee Williams on 04/12/2022.
//

import Foundation
import SwiftUI

struct PageView: View {
    @EnvironmentObject var authentication: AuthManager
    @EnvironmentObject var apiManager: APIManager


    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color("TabBG"))
        UITabBar.appearance().barTintColor = UIColor(Color("TabBG"))
        UITabBar.appearance().unselectedItemTintColor = .white
        }
    
    var body: some View {
        TabView {
            TopView()
                .environmentObject(apiManager)
                .tabItem {
                    Image(systemName: "house")
                        .padding(.bottom, 100)

                    Text("Recap")
                        .foregroundColor(.white)
                }
            PopularityView()
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("Popularity")
                        .foregroundColor(.white)
                }

            ResultsView(resultStyle: "Artist")
                .tabItem {
                    Image(systemName: "person.fill.viewfinder")
                    Text("Artist Finder")
                        .foregroundColor(.white)
                }
            
            SongFinderView()
                .tabItem {
                    Image(systemName: "waveform")
                    Text("Song Finder")
                        .foregroundColor(.white)
                }
            
        }
        .accentColor(Color("Button"))
        .onAppear{
            UITabBar.appearance().backgroundColor = UIColor(Color("TabBG"))
            UITabBar.appearance().barTintColor = UIColor(Color("TabBG"))
            UITabBar.appearance().unselectedItemTintColor = .white
            
            self.apiManager.getData()
        }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView()
        
    }
}
