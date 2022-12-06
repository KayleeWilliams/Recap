//
//  SavedStyles.swift
//  Recap
//
//  Created by Kaylee Williams on 06/12/2022.
//

import Foundation
import SwiftUI

struct TopGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .padding()
            .background(Color("AltBG"))
            .cornerRadius(10)
            .shadow(color: Color("Shadow"), radius: 5, x: 0, y: 0)
    }
}


