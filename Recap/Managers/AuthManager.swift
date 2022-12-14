//
//  AuthManager.swift
//  Recap
//
//  Created by Kaylee Williams on 08/12/2022.
//

import Foundation
import KeychainAccess
//import CryptoKit
import CommonCrypto

class AuthManager: ObservableObject {
    @Published var isValidated = false
    @Published var loginVisible = false
    
    let clientID = "09b5f29ff349407d8f16aad612e032cd"
    let redirectUri = URL(string: "https://www.kayleewilliams.dev")!
    let authURL = URL(string: "https://accounts.spotify.com/authorize")!
    let tokenURL = URL(string: "https://accounts.spotify.com/api/token")!
    var scope = "user-top-read playlist-modify-private"
    let authorizationURL: URL
    let clientSecret = "27245688409c49d3951500661f5d6caa"
    
    
    // Generate a random string to use as the state parameter and the code verifier for PKCE
    var buffer = [UInt8](repeating: 0, count: 32)
    var verifier: String
    

    init() {
        _ = SecRandomCopyBytes(kSecRandomDefault, buffer.count, &buffer)
        verifier = Data(buffer).base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
        
        // Make challenge
        let data = verifier.data(using: .utf8)
        var buffer = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        _ = data?.withUnsafeBytes {
            CC_SHA256($0.baseAddress, CC_LONG(data!.count), &buffer)
        }
        let hash = Data(buffer)
        let challenge = hash.base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
                                  
        var urlComponents = URLComponents(url: authURL, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: clientID),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "scope", value: scope),
            URLQueryItem(name: "redirect_uri", value: redirectUri.absoluteString),
            URLQueryItem(name: "code_challenge_method", value: "S256"),
            URLQueryItem(name: "code_challenge", value: challenge)
        ]
        authorizationURL = urlComponents.url!
    }
    
    func exchangeCode(code: String) {
        var request = URLRequest(url: tokenURL)

        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        let body = "grant_type=authorization_code&code=\(code)&redirect_uri=\(redirectUri.absoluteString)&client_id=\(clientID)&code_verifier=\(verifier)"
        request.httpBody = body.data(using: .utf8)
    
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    let keychain = Keychain(service: "dev.kayleewilliams.recap.keychain")
                    try keychain.set(json["access_token"] as! String, key: "accessToken")
                    self.isValidated = true
                } catch {
                    print("Error: \(error)")
                }
            }
        }
        task.resume()
    }

    
    
    
    //    func exchangeCode(code: String) {
    //        let grantType = "authorization_code"
    //        let base64Encoded = Data("\(self.clientID):\(self.clientSecret)".utf8).base64EncodedString()
    //        let tokenRequestString = "https://accounts.spotify.com/api/token"
    //
    //        let url = URL(string: tokenRequestString)!
    //        var request = URLRequest(url: url)
    //
    //        // Set headers & method
    //        request.httpMethod = "POST"
    //        request.setValue("Basic \(base64Encoded)", forHTTPHeaderField: "Authorization")
    //        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    //
    //        // Set form content
    //        let body = "grant_type=\(grantType)&code=\(code)&redirect_uri=\(self.redirectUri)".data(using: .utf8)
    //        request.httpBody = body
    //
    //        let task = URLSession.shared.dataTask(with: request) { data, response, error in
    //            if let error = error {
    //                print("Error: \(error)")
    //                return
    //            }
    //
    //            if let data = data {
    //                do {
    //                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
    //                    let keychain = Keychain(service: "dev.kayleewilliams.recap.keychain")
    //                    try keychain.set(json["access_token"] as! String, key: "accessToken")
    //                    self.isValidated = true
    //                } catch {
    //                    print("Error: \(error)")
    //                }
    //            }
    //        }
    //        task.resume()
    //    }
    //}
}
