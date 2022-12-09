//
//  SplashView.swift
//  Recap
//
//  Created by Kaylee Williams on 09/12/2022.
//

import Foundation
import SwiftUI

struct SplashView: View {
    @State private var size = 0.4
    @State private var opacity = 0.5

    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            VStack {
                Image("Cover")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 400)
                    .opacity(opacity)
                    .scaleEffect(size)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 0.7
                            self.opacity = 1.0
                        }
                    }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
