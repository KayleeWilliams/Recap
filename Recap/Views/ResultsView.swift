//
//  ResultsView.swift
//  Recap
//
//  Created by Kaylee Williams on 07/12/2022.
//

import Foundation
import SwiftUI

struct ResultsView: View {
    @EnvironmentObject var apiManager: APIManager
    @Binding var showResults: Bool
    @State private var showAlert = false

    var resultStyle: String
    
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            VStack {
                Text("\(resultStyle) Results")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.bottom, 8)
                    .foregroundColor(Color("PrimaryText"))
                
                ScrollView {
                    VStack {
                        if resultStyle == "Song Finder" {
                            if let tracks = apiManager.songRec?.tracks {
                                ForEach(0..<tracks.count, id: \.self) { index in
                                    TrackResultView(track: tracks[index])
                                }
                            }
                        }
                        if resultStyle == "Artist Finder" {
                            if let artists = apiManager.relatedArtists {
                                ForEach(0..<artists.count, id: \.self) { index in
                                    ArtistResultView(artist: artists[index])
                                }
                            }
                        }
                    }
                }
                
                HStack(spacing: 12) {
                    
                    Button(action: {
                        if resultStyle == "Song Finder" {
                            apiManager.addTracks(trackIDs: (apiManager.songRec?.tracks)!) { result in
                                showAlert = true
                                //                            }
                            }
                        } else {
                            apiManager.playlistByArtist(artists: apiManager.relatedArtists!) { result in
                                showAlert = true
                            }
    
                        }
                    }, label: {
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
                    }).alert(Text("Playlist Created!"), isPresented: $showAlert) {
                        Button("OK") { showAlert.toggle() }
                    } message: {
                        Text("Your new playlist has been added to your Spotify library.")
                    }
                    
                    Button(action: {self.showResults = false}, label: {
                        HStack(spacing: 6) {
                            Image(systemName: "arrow.clockwise")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                                .foregroundColor(Color("Button"))
        
                            Text("Restart")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(Color("Button"))
                        }
                        .padding()
                        .background(Color("AltButton"))
                        .cornerRadius(10)
                    })
                }
                .padding(.bottom, 32)
                .padding(.top, 6)
                
            }
        }
    }
}

struct TrackResultView: View {
    var track: Track
    
    var body: some View {
        HStack() {
            AsyncImage(url: URL(string: (track.album?.images![0].url)!), content: { returnedImage in
                if let returnedImage = returnedImage.image {
                    returnedImage
                        .resizable()
                        .frame(width: 48, height: 48)
                        .cornerRadius(12)
                        .padding(.leading, 12)
                } else {
                    Image("Placeholder")
                        .resizable()
                        .frame(width: 48, height: 48)
                        .cornerRadius(12)
                        .padding(.leading, 12)
                }
            })
            VStack(alignment: .leading) {
                Text("\(track.name!)".prefix(20))
                    .foregroundColor(Color("PrimaryText"))
                    .font(.system(size: 20, weight: .bold))
                
                Text("\(track.artists![0].name!)".prefix(20))
                    .foregroundColor(Color("AltText"))
                    .font(.system(size: 20, weight: .medium))
            }
            .padding(.leading, 6)
            
        }
        .frame(width: 300, height: 64, alignment: .leading)
        .background(Color("AltBG"))
        .cornerRadius(12)
    }
}

struct ArtistResultView: View {
    var artist: Artist
    
    var body: some View {
        HStack() {
            if let images = artist.images, let image = images.first {
                AsyncImage(url: URL(string: (image.url)!), content: { returnedImage in
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
            }
            VStack(alignment: .leading) {
                Text("\(artist.name!)".prefix(20))
                    .foregroundColor(Color("PrimaryText"))
                    .font(.system(size: 20, weight: .bold))
                
                Text("\(artist.genres!.prefix(2).joined(separator: ", ").capitalized)".prefix(20))
                    .foregroundColor(Color("AltText"))
                    .font(.system(size: 20, weight: .medium))
            }
            .padding(.leading, 6)
            
        }
        .frame(width: 300, height: 64, alignment: .leading)
        .background(Color("AltBG"))
        .cornerRadius(12)
    }
}
