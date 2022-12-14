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


    
    let keychain = Keychain(service: "dev.kayleewilliams.recap.keychain")
    
    func getToken() -> String? {
        let keychain = Keychain(service: "dev.kayleewilliams.recap.keychain")
        do { let accessToken = try keychain.get("accessToken"); return accessToken!
        } catch { print(error); return nil }
    }
    
    func getData() {
        getTopTracks(timeRange: "short_term") { (result) in
            self.topTracksShort = result
        }
        getTopTracks(timeRange: "medium_term") { (result) in
            self.topTracksMedium = result
        }
        getTopTracks(timeRange: "long_term") { (result) in
            self.topTracksLong = result
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
//                do {
//                     let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//                    print(type(of: data))
                completion(data)
//                } catch { print(error) }
            }
        }
        
        task.resume()
    }
    
    
}
    

