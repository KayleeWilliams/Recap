//
//  ResultsView.swift
//  Recap
//
//  Created by Kaylee Williams on 07/12/2022.
//

import Foundation
import SwiftUI

struct ResultsView: View {
    var resultStyle: String
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            VStack {
                Text("\(resultStyle) Result")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.bottom, 8)
                    .foregroundColor(Color("PrimaryText"))
                
                ScrollView {
                    VStack {
                        ForEach(0..<15) { _ in
                            ResultView(resultStyle: resultStyle)
                        }
                    }
                }
                
                HStack(spacing: 12) {
                    Button(action: {}, label: {
                        HStack(spacing: 6) {
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                                .foregroundColor(Color("ButtonText"))
        
                            Text("Playlist")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(Color("ButtonText"))
                        }
                        .padding()
                        .background(Color("Button"))
                        .cornerRadius(10)
                    })
                    
                    Button(action: {}, label: {
                        HStack(spacing: 6) {
                            Image(systemName: "arrow.clockwise")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                                .foregroundColor(Color("Button"))
        
                            Text("Restart")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(Color("Button"))
                        }
                        .padding()
                        .background(Color("AltButton"))
                        .cornerRadius(10)
                    })
                }
                .padding(.bottom, 32)
                .padding(.top, 6)
                
            }
        }
    }
}

struct ResultView: View {
    var resultStyle: String
    var body: some View {
        HStack() {
            Image("Placeholder")
                .resizable()
                .frame(width: 48, height: 48)
                .cornerRadius(resultStyle == "Artist" ? 100 : 12)
                .padding(.leading, 12)
            
            VStack(alignment: .leading) {
                Text("Title")
                    .foregroundColor(Color("PrimaryText"))
                    .font(.system(size: 20, weight: .bold))
                
                Text("Alt Text")
                    .foregroundColor(Color("AltText"))
                    .font(.system(size: 20, weight: .medium))
            }
            .padding(.leading, 6)
            
        }
        .frame(width: 300, height: 64, alignment: .leading)
        .background(Color("AltBG"))
        .cornerRadius(12)
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(resultStyle: "Artist")
        
    }
}
