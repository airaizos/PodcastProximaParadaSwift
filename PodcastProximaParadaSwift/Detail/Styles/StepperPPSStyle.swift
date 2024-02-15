//
//  StepperPPSStyle.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 18/10/23.
//

import SwiftUI


struct StepperPPSStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack{
            configuration.label
                .foregroundStyle(configuration.isPressed ? Color.darkest : Color.clear1)
                .zIndex(1)
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 0.3)
                .foregroundStyle(configuration.isPressed ? Color.pink1 : Color.black.opacity(0.7))
                .padding(8)
                .frame(width: 64, height: 44)
               
                .zIndex(configuration.isPressed ? -1 : 0)
            
            RoundedRectangle(cornerRadius: 8)
                .fill(configuration.isPressed ? Color.pinkest.opacity(0.8) : Color.gray.opacity(0.1))
                .padding(8)
                .frame(width: 64, height: 44)
                .zIndex((configuration.isPressed ? 0 : -1))
           
               
            
        }
        
    }
    
}
