//
//  EnlacesView.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 16/10/23.
//

import SwiftUI

struct EnlacesView: View {
    @StateObject var vm = EnlacesViewModel()
    
    @State var text:AttributedString  = ""
    
    var body: some View {
        ZStack {
            VStack(spacing: 5) {
                Text("Enlaces")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(Color.darkest)
                AsyncImage(url: .logoSwift, scale: 3)
                ScrollView {
                    Text(text)
                        .fontDesign(.rounded)
                }
                .padding(.horizontal)
                .onAppear {
                    Task {
                        text = await vm.fetchEnlaces()
                    }
                }
                Divider()
                    .background(Color.pink1)
            }
            Color.pink1
                .ignoresSafeArea()
                .zIndex(-1)
        }
    }
}

#Preview {
    EnlacesView()
}
