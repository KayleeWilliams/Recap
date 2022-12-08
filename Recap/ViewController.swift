//
//  WebView.swift
//  Recap
//
//  Created by Kaylee Williams on 30/11/2022.
//

import Foundation
import WebKit
import SwiftUI

import UIKit


//struct WebView: UIViewRepresentable {
//
//    var url: URL
//
//    func makeUIView(context: Context) -> WKWebView {
//        return WKWebView()
//    }
//
//    func updateUIView(_ webView: WKWebView, context: Context) {
//        let request = URLRequest(url: url)
//        webView.load(request)
//    }
//}

struct WebView: UIViewRepresentable {
    
    var url: URL
    var navigationController: UINavigationController?

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.navigationDelegate = context.coordinator
        webView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: WebView
        
        init (_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            
            if let navURL = navigationAction.request.url {
                if navURL.host! == "www.kayleewilliams.dev" {
                    let code = URLComponents(string: navURL.absoluteString)?.queryItems?.first(where: { $0.name == "code" })?.value
                    if code != nil {
                        webView.removeFromSuperview()
                        
                        // Async wait for accessToken to be retrieved.
                        func getAccessToken() {
                          DispatchQueue.global().async {
                              AuthManager.shared.exchangeCode(code: code!)
                          }
                        }
                        getAccessToken()
                        print(UserDefaults.standard.value(forKey: "accessToken")!)
                        
                    }
                }
            }
            
            decisionHandler(.allow)
        }
    }
}

