//
//  SplashView.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 19/10/23.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            VStack(spacing: 150){
                Image("splash")
                    .resizable()
                    .scaledToFit()
                   
                  
                    .clipShape(Circle())
                    .brightness(0.15)
                   // .shadow(color: .clear1, radius: 5, x: 5, y: 5)
                    .overlay(Circle().stroke(lineWidth: 50).foregroundStyle(Color.clear1.opacity(0.5)).blur(radius: 10))
                 //   .shadow(color: .darkest, radius: 5, x: 5, y: 5)
               
                Text("Podcast \n Próxima Parada Swift")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.dark)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .fontWidth(.expanded)
                    .fontDesign(.rounded)
                
                Text("by Adrintro")
                    .font(.caption2)
                    .foregroundStyle(Color.dark)
            }
         
            RadialGradientView()
                .zIndex(-1)
                .ignoresSafeArea()
        }
        .blendMode(.plusDarker)
       
    }
}

#Preview {
    SplashView()
}

struct RadialGradientView: View {
    var body: some View {
        RadialGradient(gradient: Gradient(colors: [Color.clear1, Color.clear1.opacity(0.9), Color.clear1.opacity(0.7), Color.clear1.opacity(0.5), Color.clear1.opacity(0.3), Color.clear1.opacity(0.0)]),
                       center: .center,
                       startRadius: 20,
                       endRadius: 500)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
