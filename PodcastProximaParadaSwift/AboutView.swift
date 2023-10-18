//
//  AboutView.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 16/10/23.
//

import SwiftUI

struct AboutView: View {
    @StateObject var vm = AboutViewModel()
    
    @State var text:AttributedString = ""
    
    var body: some View {
        ZStack{
            VStack {
                Text("Sobre mí")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(Color.darkest)
                ScrollView {
                    AsyncImage(url: .perfilPhoto) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } placeholder: {
                        
                    }
                    
                    Text(text)
                        .fontDesign(.rounded)
                    
                    
                }
                
                .padding()
                Divider()
                    .background(Color.pinkest)
            }
            Color.pinkest
                .ignoresSafeArea()
                .zIndex(-1)
        }
        .onAppear {
            Task {
                text = await vm.fetchPageAboutMe()
            }
        }
    }
}

#Preview {
    AboutView()
}
