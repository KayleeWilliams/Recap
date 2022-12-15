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
    
    @Published var topAlbumsShort: [Album]?
    @Published var topAlbumsMedium: [Album]?
    @Published var topAlbumsLong: [Album]?
    
    let keychain = Keychain(service: "dev.kayleewilliams.recap.keychain")
    
    func getToken() -> String? {
        let keychain = Keychain(service: "dev.kayleewilliams.recap.keychain")
        do { let accessToken = try keychain.get("accessToken"); return accessToken!
        } catch { print(error); return nil }
    }
    
    func getData() {
        // Async as Publishing changes from background threads is not allowed; make sure to publish values from the main thread.
        self.getTopTracks(timeRange: "short_term") { (result) in
            DispatchQueue.main.async { self.topTracksShort = result }
        }
        self.getTopTracks(timeRange: "medium_term") { (result) in
            DispatchQueue.main.async { self.topTracksMedium = result }
        }
        self.getTopTracks(timeRange: "long_term") { (result) in
            DispatchQueue.main.async { self.topTracksLong = result }
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
    

