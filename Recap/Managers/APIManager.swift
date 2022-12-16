//
//  APIManager.swift
//  Recap
//
//  Created by Kaylee Williams on 14/12/2022.
//

import Foundation
import KeychainAccess

class APIManager: ObservableObject {
    @Published var topTracksShort: TracksModel?
    @Published var topTracksMedium: TracksModel?
    @Published var topTracksLong: TracksModel?

    @Published var topArtistsShort: ArtistsModel?
    @Published var topArtistsMedium: ArtistsModel?
    @Published var topArtistsLong: ArtistsModel?
    
    @Published var topAlbumsShort: Array<(key: String, value: (Album, Int))>?
    @Published var topAlbumsMedium: Array<(key: String, value: (Album, Int))>?
    @Published var topAlbumsLong: Array<(key: String, value: (Album, Int))>?
    
    let keychain = Keychain(service: "dev.kayleewilliams.recap.keychain")
    
    func getToken() -> String? {
        let keychain = Keychain(service: "dev.kayleewilliams.recap.keychain")
        do { let accessToken = try keychain.get("accessToken"); return accessToken!
        } catch { print(error); return nil }
    }
    
    func getData() {
        // Async as Publishing changes from background threads is not allowed; make sure to publish values from the main thread.
        self.getTopTracks(timeRange: "short_term") { (result) in
            DispatchQueue.main.async {
                self.topTracksShort = result
                self.topAlbumsShort = self.getAlbums(tracks: result!)
            }
        }
        self.getTopTracks(timeRange: "medium_term") { (result) in
            DispatchQueue.main.async {
                self.topTracksMedium = result
                self.topAlbumsMedium = self.getAlbums(tracks: result!)
            }
        }
        self.getTopTracks(timeRange: "long_term") { (result) in
            DispatchQueue.main.async {
                self.topTracksLong = result
                self.topAlbumsLong = self.getAlbums(tracks: result!)
            }
        }
        
        self.getTopArtists(timeRange: "short_term") { (result) in
            DispatchQueue.main.async { self.topArtistsShort = result }
        }
        self.getTopArtists(timeRange: "medium_term") { (result) in
            DispatchQueue.main.async { self.topArtistsMedium = result }
        }
        self.getTopArtists(timeRange: "long_term") { (result) in
            DispatchQueue.main.async { self.topArtistsLong = result }
        }
        
        
    }
    
    func getAlbums(tracks: TracksModel) -> Array<(key: String, value: (Album, Int))>? {
        let albumCountsById = tracks.items!.reduce(into: [String: (Album, Int)]()) { albums, item in
            if let album = item.album {
                if album.albumType == "ALBUM" {
                    if let entry = albums[album.id!] {
                        albums[album.id!] = (entry.0, entry.1 + 1)
                    } else {
                        albums[album.id!] = (album, 1)
                    }
                }
            }
        }
        let sortedAlbumIDCounts = albumCountsById.sorted { $0.value.1 > $1.value.1 }
        return sortedAlbumIDCounts
    }
    
    func getTopTracks(timeRange: String, completion: @escaping (TracksModel?) -> Void) {
        let type = "tracks"
        let limit = 50
        
        let url = URL(string: "https://api.spotify.com/v1/me/top/\(type)?time_range=\(timeRange)&limit=\(limit)")!
        fetch(url: url) { (json) in
            let decoder = JSONDecoder()
            let result = try? decoder.decode(TracksModel.self, from: json)
            completion(result)
        }
    }
    
    func getTopArtists(timeRange: String, completion: @escaping (ArtistsModel?) -> Void) {
        let type = "artists"
        let limit = 50
        
        let url = URL(string: "https://api.spotify.com/v1/me/top/\(type)?time_range=\(timeRange)&limit=\(limit)")!
        fetch(url: url) { (json) in
            let decoder = JSONDecoder()
            let result = try? decoder.decode(ArtistsModel.self, from: json)
            completion(result)
        }
    }
    
    func fetch(url: URL, completion: @escaping (Data) -> Void) {
        let accessToken = getToken()
  
        // Create a URLRequest object with the URL
        var request = URLRequest(url: url)
        request.addValue("Bearer \(accessToken!)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            if let data = data {
                completion(data)
            }
        }
        
        task.resume()
    }
    
    
}
    

