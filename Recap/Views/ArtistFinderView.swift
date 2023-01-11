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
//    @State var shuffledArtists: [Artist] = []
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
                Spacer()
                if !artists.isEmpty {
                    ForEach(artists.prefix(2).indices, id: \.self, content: { index in
                        VStack(alignment: .center) {
                            AsyncImage(url: URL(string: (artists[index].images![0].url)!), content: { phase in
                                if let image = phase.image {
                                    image
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
                            if ((selectedArtists.count == 0) || selectedArtists.count == 5) {
                                DispatchQueue.main.async {
                                    apiManager.getRelatedArtists(ids: selectedArtists)
                                    showResults = true
                                }
                            }
                        }
                        if index == 0 {
                            Spacer()
                            Text("OR")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(Color("PrimaryText"))
                            Spacer()
                        }
                    }).onDelete { indices in
                        indices.forEach { artists.remove(at: $0) }
                    }
                }
                Spacer()
            }.onAppear{self.artists = (self.apiManager.topArtistsMedium?.items)!.prefix(15).shuffled()}
        }
    }
}
