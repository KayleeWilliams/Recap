//
//  TopTracks.swift
//  Recap
//
//  Created by Kaylee Williams on 04/12/2022.
//

import Foundation
import SwiftUI

struct TopTracks: View {
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            VStack {
                Text("Tracks Recap")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.bottom, 8)
                    .foregroundColor(Color("PrimaryText"))

                
                // Top View Change
                HStack(spacing: 30) {
                    Button(action: {}, label: {
                        Text("Tracks")
                            .font(.system(size: 17, weight: .bold))
                        .foregroundColor(Color("Button"))})
                    Button(action: {}, label: {
                        Text("Artists")
                            .font(.system(size: 17, weight: .bold))
                        .foregroundColor(Color("PrimaryText"))})
                    Button(action: {}, label: {
                        Text("Albums")
                            .font(.system(size: 17, weight: .bold))
                        .foregroundColor(Color("PrimaryText"))})
                    Button(action: {}, label: {
                        Text("Genres")
                            .font(.system(size: 17, weight: .bold))
                        .foregroundColor(Color("PrimaryText"))})
                }
                
                // Content
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(0..<10) { _ in
                            TrackView()
                        }
                    }
                    .padding(.horizontal, 20)
                }
                
            }
        }
    }
}

struct TopTracks_Previews: PreviewProvider {
    static var previews: some View {
        TopTracks()
        
    }
}

struct TrackView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image("Placeholder")
                .resizable()
                .frame(width: 160, height: 160)
            HStack(spacing: 4) {
                Text("1.")
                    .foregroundColor(Color("AltText"))
                    .font(.system(size: 14, weight: .medium))
                Text("Song Name")
                    .foregroundColor(Color("PrimaryText"))
                    .font(.system(size: 14, weight: .bold))
            }
            Text("Artist")
                .foregroundColor(Color("AltText"))
                .font(.system(size: 14, weight: .medium))
        }
    }
}
