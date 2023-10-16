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
            ScrollView {
                Text(text)
                    .fontDesign(.rounded)
            }
            .padding()
            .onAppear {
                Task {
                    text = await vm.fetchEnlaces()
                }
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
