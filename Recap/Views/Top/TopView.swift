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
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(Color("Button")),
            .font: UIFont.systemFont(ofSize: 17, weight: .bold)
        ]
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(Color("PrimaryText")),
            .font: UIFont.systemFont(ofSize: 17, weight: .bold)
        ]
        
        UISegmentedControl.appearance().setTitleTextAttributes(selectedAttributes, for: .selected)
        
        UISegmentedControl.appearance().setTitleTextAttributes(normalAttributes, for: .normal)
                
        UISegmentedControl.appearance().selectedSegmentTintColor = .clear
        
        UISegmentedControl.appearance().backgroundColor = UIColor(Color("AltBG"))

    }
    
    @State private var selectedTop = "Tracks"
    @State private var selectedTime = "1 Month"

    var sections = ["Tracks", "Artists", "Albums", "Genres"]
    var times = ["1 Month", "6 Months", "Lifetime"]
    
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            VStack {
                Text("\(selectedTop) Recap")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.bottom, 8)
                    .foregroundColor(Color("PrimaryText"))
                
                // Section Picker
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
                
                // Time Picker
                Picker(selection: $selectedTime, label: Text("Top")) {
                    ForEach(times, id: \.self) {
                        Text($0)
                            .font(.system(size: 17, weight: .bold))
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding([.horizontal], 20)
                .padding([.bottom, .top], 8)
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

// Twmp dummy data
struct BarChart: View {
    let genreList = [
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
            ForEach(genreList) { genre in
                BarMark(
                    x: .value("Value", genre.value),
                    y: .value("Genre", genre.label)
                )
                .foregroundStyle(Color("Button"))
                .annotation (position: .overlay, alignment: .leading, spacing: 10) {
                    Text("\(genre.label)")
                        .foregroundColor(Color("ButtonText"))
                        .fontWeight (.bold)
                }
            }
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)

    }
}
