//
//  TogglePPSStyle.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 17/10/23.
//

import SwiftUI

struct TogglePPSStyle: ToggleStyle {
    var label = ""
    var color = Color.clear1
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            
            Text(label)
            Spacer()
            Button(action: {configuration.isOn.toggle() }) {
              
            }
        }
    }
}

