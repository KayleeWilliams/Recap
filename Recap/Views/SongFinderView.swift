//
//  SongFinderView.swift
//  Recap
//
//  Created by Kaylee Williams on 07/12/2022.
//

import Foundation
import SwiftUI


struct SongFinderView: View {
    @EnvironmentObject var apiManager: APIManager
    @State private var multiSelection: [String] = []
    @State private var showResults = false

    let selectedBadge = Text("\(Image(systemName: "checkmark"))")
        .foregroundColor(Color("Button"))
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            if showResults {
                ResultsView(showResults: $showResults, resultStyle: "Song Finder")
                    .environmentObject(apiManager)
                    .onDisappear{showResults = false}
            } else {
                ListView(showResults: $showResults)
            }
        }
    }
}

struct SongFinderView_Previews: PreviewProvider {
    static var previews: some View {
        SongFinderView()
        
    }
}

struct ListView: View {
    @EnvironmentObject var apiManager: APIManager
    @State private var multiSelection: [String] = []
    @Binding var showResults: Bool

    let selectedBadge = Text("\(Image(systemName: "checkmark"))")
        .foregroundColor(Color("Button"))
    
    var body: some View {
        VStack {
            Text("Song Finder")
                .font(.system(size: 20, weight: .bold))
                .padding(.bottom, 8)
                .foregroundColor(Color("PrimaryText"))
            
            List() {
                ForEach((apiManager.genreSeeds?.genres)!, id: \.self) { genre in
                    Button(action: {
                        if multiSelection.contains(genre) {
                            multiSelection.removeAll(where: { $0 == genre })
                        } else {
                            multiSelection.append(genre)
                            if multiSelection.count > 5 {
                                multiSelection.removeFirst()
                            }
                        }
                    }) {
                        HStack {
                            Text(genre)
                                .badge(multiSelection.contains(genre) ? selectedBadge : nil )
                                .foregroundColor(Color("PrimaryText"))
                                .font(.system(size: 17, weight: .medium))
                        }
                    }
                }
                .listRowBackground(Color("AltBG"))
            }
            .scrollContentBackground(.hidden)
        
            HStack(spacing: 12) {
                Button(action: {
                    apiManager.getRecByGenre(selection: multiSelection) {
                        result in
                        showResults.toggle()
                    }}, label: {
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
