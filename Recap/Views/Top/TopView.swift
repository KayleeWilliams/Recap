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
    @EnvironmentObject var apiManager: APIManager

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
    
    enum Times: String, CaseIterable {
        case short = "1 Month"
        case medium = "6 Months"
        case long = "Lifetime"
    }
    
    @State private var selectedTop = "Tracks"
    @State private var selectedTime: Times = .short

    var sections = ["Tracks", "Artists", "Albums", "Genres"]

    private func getItems() -> [Any] {
        switch (selectedTop, selectedTime) {
        case ("Artists", .short): return apiManager.topArtistsShort?.items ?? []
        case ("Artists", .medium): return apiManager.topArtistsMedium?.items ?? []
        case ("Artists", .long): return apiManager.topArtistsLong?.items ?? []
        case ("Tracks", .short): return apiManager.topTracksShort?.items ?? []
        case ("Tracks", .medium): return apiManager.topTracksMedium?.items ?? []
        case ("Tracks", .long): return apiManager.topTracksLong?.items ?? []
        case ("Albums", .short): return apiManager.topAlbumsShort?.map { $0.value.0 } ?? []
        case ("Albums", .medium): return apiManager.topAlbumsMedium?.map { $0.value.0 } ?? []
        case ("Albums", .long): return apiManager.topAlbumsLong?.map { $0.value.0 } ?? []
        default: return []
        }
    }
    
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
                        ForEach(0..<getItems().count, id: \.self) { index in
                            VStack {
                                if selectedTop == "Artists" {
                                    ArtistView(artist: getItems()[index] as! Artist, id: "\(index+1)")
                                } else if selectedTop == "Tracks" {
                                    TrackView(track: getItems()[index] as! Track, id: "\(index+1)")
                                } else if selectedTop == "Albums" {
                                    AlbumView(album: getItems()[index] as! Album, id: "\(index+1)")
                                }
                            }
                        }
                    }.padding(.horizontal, 20)
                    
                    if selectedTop == "Genres" {
                        GenresView()
                    }
                }
                
                Picker(selection: $selectedTime, label: Text("Top")) {
                    ForEach(Times.allCases, id: \.self) { time in
                        Text(time.rawValue)
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
    var track: Track
    var id: String
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: (track.album?.images![0].url)!), content: { returnedImage in
                if let returnedImage = returnedImage.image {
                    returnedImage
                        .resizable()
                        .frame(width: 160, height: 160)
                        .cornerRadius(8)
                } else {
                    Image("Placeholder")
                        .resizable()
                        .frame(width: 160, height: 160)
                        .cornerRadius(8)
                }
            })
            HStack(spacing: 4) {
                Text("\(id).")
                    .foregroundColor(Color("AltText"))
                    .font(.system(size: 14, weight: .medium))
                Text("\(track.name!)".prefix(20))
                    .foregroundColor(Color("PrimaryText"))
                    .font(.system(size: 14, weight: .bold))
            }
            Text("\(track.artists![0].name!)")
                .foregroundColor(Color("AltText"))
                .font(.system(size: 14, weight: .medium))
        }
    }
}

struct ArtistView: View {
    var artist: Artist
    var id: String
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: (artist.images![0].url)!), content: { returnedImage in
                if let returnedImage = returnedImage.image {
                    returnedImage
                        .resizable()
                        .frame(width: 160, height: 160)
                        .cornerRadius(8)
                } else {
                    Image("Placeholder")
                        .resizable()
                        .frame(width: 160, height: 160)
                        .cornerRadius(8)
                }
            })
            HStack(spacing: 4) {
                Text("\(id).")
                    .foregroundColor(Color("AltText"))
                    .font(.system(size: 14, weight: .medium))
                Text("\(artist.name!)".prefix(20))
                    .foregroundColor(Color("PrimaryText"))
                    .font(.system(size: 14, weight: .bold))
            }
//            Text("Artist")
//                .foregroundColor(Color("AltText"))
//                .font(.system(size: 14, weight: .medium))
        }
    }
}

struct AlbumView: View {
    var album: Album
    var id: String
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: (album.images![0].url)!), content: { returnedImage in
                if let returnedImage = returnedImage.image {
                    returnedImage
                        .resizable()
                        .frame(width: 160, height: 160)
                        .cornerRadius(8)
                } else {
                    Image("Placeholder")
                        .resizable()
                        .frame(width: 160, height: 160)
                        .cornerRadius(8)
                }
            })
            HStack(spacing: 4) {
                Text("\(id).")
                    .foregroundColor(Color("AltText"))
                    .font(.system(size: 14, weight: .medium))
                Text(album.name!.prefix(20))
                    .foregroundColor(Color("PrimaryText"))
                    .font(.system(size: 14, weight: .bold))
            }
            Text(album.artists![0].name!)
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

//struct TrackGrid: View {
//    let tracks: [Track]
//    var body: some View {
//        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
//            if let indices = tracks.indices {
//                ForEach(indices, id: \.self) { index in
//                    TrackView(track: (tracks[index], id: "\(index+1)")
//                }
//            }
//        }.padding(.horizontal, 20)
//    }
//}
