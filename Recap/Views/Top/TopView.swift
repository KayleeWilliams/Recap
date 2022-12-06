//
//  TopArtists.swift
//  Recap
//
//  Created by Kaylee Williams on 04/12/2022.
//

import Foundation
import SwiftUI
import Charts

struct TopView: View {
    // Style Segment Control bar
    init() {
        let backgroundColor = UIColor(Color("Background"))
        let buttonColor = UIColor(Color("Button"))
        let primaryTextColor = UIColor(Color("PrimaryText"))

        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: buttonColor,
            .font: UIFont.systemFont(ofSize: 17, weight: .bold)
        ]
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: primaryTextColor,
            .font: UIFont.systemFont(ofSize: 17, weight: .bold)
        ]
        
        UISegmentedControl.appearance().backgroundColor = backgroundColor
        UISegmentedControl.appearance().selectedSegmentTintColor = .clear
        UISegmentedControl.appearance().setTitleTextAttributes(selectedAttributes, for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes(normalAttributes, for: .normal)
    }
    
    @State private var selectedTop = "Tracks"
    var sections = ["Tracks", "Artists", "Albums", "Genres"]
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            VStack {
                Text("\(selectedTop) Recap")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.bottom, 8)
                    .foregroundColor(Color("PrimaryText"))
                
                // Segmented Picker
                Picker(selection: $selectedTop, label: Text("Top")) {
                    ForEach(sections, id: \.self) {
                        Text($0)
                        .font(.system(size: 17, weight: .bold))
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding([.horizontal], 20)
                .padding([.bottom], 4)
                
                
                // Content
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        if selectedTop == "Artists" {
                            ForEach(0..<10) { _ in
                                ArtistView()
                            }
                        }
                        
                        if selectedTop == "Tracks" {
                            ForEach(0..<10) { _ in
                                TrackView()
                            }
                        }
                        
                        if selectedTop == "Albums" {
                            ForEach(0..<10) { _ in
                                AlbumsView()
                            }
                        }
                        
                    }
                    .padding(.horizontal, 20)

                    if selectedTop == "Genres" {
                        GenresView()
                    }
                }
                
            }
        }
    }
}

struct TopArtists_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
        
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

struct ArtistView: View {
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
//            Text("Artist")
//                .foregroundColor(Color("AltText"))
//                .font(.system(size: 14, weight: .medium))
        }
    }
}

struct AlbumsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image("Placeholder")
                .resizable()
                .frame(width: 160, height: 160)
            HStack(spacing: 4) {
                Text("1.")
                    .foregroundColor(Color("AltText"))
                    .font(.system(size: 14, weight: .medium))
                Text("Album Name")
                    .foregroundColor(Color("PrimaryText"))
                    .font(.system(size: 14, weight: .bold))
            }
            Text("Artist")
                .foregroundColor(Color("AltText"))
                .font(.system(size: 14, weight: .medium))
        }
    }
}

struct GenresView: View {

    var body: some View {
        VStack {
            GroupBox() {
                BarChart()
            }
            .frame(height: 500)
            .padding([.leading, .trailing], 12)
            .groupBoxStyle(TopGroupBoxStyle())

        }
    }
}

struct GenreData: Hashable {
     var label: String
     var value: Int
 }

// Twmp dummy data
struct BarChart: View {
    let genres = [
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
    var body: some View {
        Chart {
            ForEach(genres, id: \.self) { i in
                BarMark(
                    x: .value("Value", i.value),
                    y: .value("Genre", i.label)
                )
                .foregroundStyle(Color("Button"))
                .annotation (position: .overlay, alignment: .leading, spacing: 10) {
                    Text("\(i.label)")
                        .foregroundColor(Color("ButtonText"))
                        .fontWeight (.bold)
                }
            }
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)

    }
}
