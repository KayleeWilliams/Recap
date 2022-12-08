//
//  AuthManager.swift
//  Recap
//
//  Created by Kaylee Williams on 08/12/2022.
//

import Foundation

class AuthManager {
    static let shared = AuthManager()
    
    let clientID: String
    let clientSecret: String
    let redirectUri: String
    
    private init() {
        clientID = "09b5f29ff349407d8f16aad612e032cd"
        clientSecret = "27245688409c49d3951500661f5d6caa"
        redirectUri = "https://www.kayleewilliams.dev"
    }
    
    func exchangeCode(code: String) {
        let grantType = "authorization_code"
        let base64Encoded = Data("\(self.clientID):\(self.clientSecret)".utf8).base64EncodedString()
        let tokenRequestString = "https://accounts.spotify.com/api/token"
        
        let url = URL(string: tokenRequestString)!
        var request = URLRequest(url: url)
        
        // Set headers & method
        request.httpMethod = "POST"
        request.setValue("Basic \(base64Encoded)", forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // Set form content
        let body = "grant_type=\(grantType)&code=\(code)&redirect_uri=\(self.redirectUri)".data(using: .utf8)
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    UserDefaults.standard.set(json["access_token"] as! String, forKey: "accessToken")
                    
                } catch {
                    print("Error: \(error)")
                }
            }
        }
        task.resume()
    }
}
        
//struct AuthResponse: Codable {
//    let access_token: String
//    let token_type: String
//    let expires_in: Int
//    let scope: String
//    let refresh_token: String
//}
