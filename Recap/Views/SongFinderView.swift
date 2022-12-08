//
//  SongFinderView.swift
//  Recap
//
//  Created by Kaylee Williams on 07/12/2022.
//

import Foundation
import SwiftUI

//struct Genre: Identifiable {
//    let name: String
//    let id = UUID()
//}

struct SongFinderView: View {
    @State private var multiSelection = Set<UUID>()
    let selectedBadge = Text("\(Image(systemName: "checkmark"))")
        .foregroundColor(Color("Button"))
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            VStack {
                Text("Song Finder")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.bottom, 8)
                    .foregroundColor(Color("PrimaryText"))
                
                List (selection: $multiSelection) {
                    ForEach(genreList) { genre in
                        Text(genre.label)
                            .badge(multiSelection.contains(genre.id) ? selectedBadge : nil )
                            .foregroundColor(Color("PrimaryText"))
                            .font(.system(size: 17, weight: .medium))
                    }
                    .listRowBackground(Color("AltBG"))
                }
                .scrollContentBackground(.hidden)

                HStack(spacing: 12) {
                    Button(action: {}, label: {
                        HStack(spacing: 6) {
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                                .foregroundColor(Color("ButtonText"))
        
                            Text("Playlist")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(Color("ButtonText"))
                        }
                        .padding()
                        .background(Color("Button"))
                        .cornerRadius(10)
                    })
                    
                }
                .padding(.bottom, 32)
                .padding(.top, 6)
            }
        }
    }
}

struct SongFinderView_Previews: PreviewProvider {
    static var previews: some View {
        SongFinderView()
        
    }
}


var genreList = [
    GenreData(label: "Rock", value: 100),
    GenreData(label: "Pop", value: 90),
    GenreData(label: "Hip Hop", value: 80),
    GenreData(label: "R&B", value: 70),
    GenreData(label: "Country", value: 60),
    GenreData(label: "Jazz", value: 50),
    GenreData(label: "Classical", value: 10),
    GenreData(label: "Metal", value: 40),
    GenreData(label: "Folk", value: 20),
    GenreData(label: "Electronic", value: 30),

]


