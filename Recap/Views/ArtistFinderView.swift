//
//  ArtistFinderView.swift
//  Recap
//
//  Created by Kaylee Williams on 18/12/2022.
//

import Foundation
import SwiftUI


struct ArtistFinderView: View {
    @EnvironmentObject var apiManager: APIManager
    @State private var showResults = false
    
    let selectedBadge = Text("\(Image(systemName: "checkmark"))")
        .foregroundColor(Color("Button"))
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            if showResults {
                ResultsView(showResults: $showResults, resultStyle: "Artist Finder")
                    .environmentObject(apiManager)
                    .onDisappear{showResults = false}
            } else {
                ChoicesView(showResults: $showResults)
            }
        }
    }
}

struct ChoicesView: View {
    @EnvironmentObject var apiManager: APIManager
    @Binding var showResults: Bool
    @State var artists: [Artist] = []
    @State private var selectedArtists: [String] = []
    
    let selectedBadge = Text("\(Image(systemName: "checkmark"))")
        .foregroundColor(Color("Button"))
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            VStack {
                Text("Artist Finder")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.bottom, 8)
                    .foregroundColor(Color("PrimaryText"))
                
                if !artists.isEmpty {
                    ForEach(artists.prefix(2).indices, id: \.self, content: { index in
                        VStack(alignment: .center) {
                            AsyncImage(url: URL(string: (artists[index].images![0].url)!), content: { returnedImage in
                                if let returnedImage = returnedImage.image {
                                    returnedImage
                                        .resizable()
                                        .frame(width: 240, height: 240)
                                        .cornerRadius(8)
                                } else {
                                    Image("Placeholder")
                                        .resizable()
                                        .frame(width: 240, height: 240)
                                        .cornerRadius(8)
                                }
                            })
                            Text(artists[index].name!)
                        }.onTapGesture {
                            selectedArtists.append(artists[index].id!)
                            artists.remove(at: index)
                            if ((artists.count == 0) || selectedArtists.count == 5) {
                                DispatchQueue.main.async {
                                    apiManager.getRelatedArtists(ids: selectedArtists)
                                    showResults = true
                                }
                            }
                        }
                    }).onDelete { indices in
                        indices.forEach { artists.remove(at: $0) }
                    }
                }
            }.onAppear{self.artists = (self.apiManager.topArtistsMedium?.items)!}
        }
    }
}
