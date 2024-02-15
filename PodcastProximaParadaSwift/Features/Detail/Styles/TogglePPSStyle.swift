//
//  TogglePPSStyle.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 17/10/23.
//

import SwiftUI

// Se comporta raro
struct TogglePPSStyle: ToggleStyle {
    var onColor = Color.clear1
    var offColor = Color.pink1
    var thumbColor = Color.white
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .font(.callout)
                .foregroundStyle(onColor)
            Spacer()
            Button(action: { configuration.isOn.toggle() }) {
                RoundedRectangle(cornerRadius: 16, style: .circular)
                    .fill(configuration.isOn ? onColor : offColor)
                    .frame(width: 50, height: 29)
                    .overlay(
                        Circle()
                            .fill(thumbColor)
                            .shadow(radius: 1, x: 0,y:1)
                            .padding(1.5)
                            .offset(x: configuration.isOn ? 10 : -10))
                    .animation(Animation.easeInOut(duration: 0.1), value: configuration.isOn)
            }
        }
       
        .padding(.horizontal)
    }
}
