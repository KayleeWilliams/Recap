//
//  PageView.swift
//  Recap
//
//  Created by Kaylee Williams on 04/12/2022.
//

import Foundation
import SwiftUI

struct PageView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color("TabBG"))
        UITabBar.appearance().unselectedItemTintColor = .white
    }
        
    var body: some View {
        TabView {
            TopTracks()
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
            
        }
        .accentColor(Color("Button"))
    }
}



struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView()
        
    }
}
