//
//  PopularityView.swift
//  Recap
//
//  Created by Kaylee Williams on 04/12/2022.
//

import Foundation
import SwiftUI

struct PopularityView: View {
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            VStack {
                Text("Global Popularity")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.bottom, 8)
                    .foregroundColor(Color("PrimaryText"))
                
                ScrollView {
                    VStack {
                        ForEach(0..<15) { _ in
                            ArtistPopularity()
                        }
                    }
                }
                
            }
        }
    }
}

struct PopularityView_Previews: PreviewProvider {
    static var previews: some View {
        PopularityView()
        
    }
}



struct ArtistPopularity: View {
    var body: some View {
        HStack(spacing: 18) {
            Image("Placeholder")
                .resizable()
                .cornerRadius(100)
                .frame(width: 48, height: 48)
                .padding(.leading, 12)
            VStack(alignment: .leading) {
                Text("Artist Name")
                    .foregroundColor(Color("AltText"))
                    .font(.system(size: 20, weight: .medium))
                
                Text("90")
                    .foregroundColor(Color("PrimaryText"))
                    .font(.system(size: 20, weight: .bold))
            }
            
        }
        .frame(width: 300, height: 64, alignment: .leading)
        .background(Color("AltBG"))
        .cornerRadius(12)
    }
}
