//
//  PopularityView.swift
//  Recap
//
//  Created by Kaylee Williams on 04/12/2022.
//

import Foundation
import SwiftUI

struct PopularityView: View {
    @EnvironmentObject var apiManager: APIManager
    
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
                        let test = apiManager.topArtistsMedium?.items?.sorted(by: { $0.popularity! > $1.popularity! })
                        ForEach(test!, id: \.self) { artist in
                            ArtistPopularity(artist: artist)
                        }
                    }
                }.padding(.bottom, 18)
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
    let artist: Artist
    var body: some View {
        HStack(spacing: 18) {
            AsyncImage(url: URL(string: (artist.images![0].url)!), content: { returnedImage in
                if let returnedImage = returnedImage.image {
                    returnedImage
                        .resizable()
                        .frame(width: 48, height: 48)
                        .cornerRadius(100)
                        .padding(.leading, 12)
                } else {
                    Image("Placeholder")
                        .resizable()
                        .frame(width: 48, height: 48)
                        .cornerRadius(100)
                        .padding(.leading, 12)
                }
            })
            VStack(alignment: .leading) {
                Text("\(artist.name!)")
                    .foregroundColor(Color("AltText"))
                    .font(.system(size: 20, weight: .medium))
                
                Text("\(artist.popularity!)")
                    .foregroundColor(Color("PrimaryText"))
                    .font(.system(size: 20, weight: .bold))
            }
            
        }
        .frame(width: 300, height: 64, alignment: .leading)
        .background(Color("AltBG"))
        .cornerRadius(12)
    }
}
