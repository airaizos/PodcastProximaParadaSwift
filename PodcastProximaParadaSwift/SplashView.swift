//
//  SplashView.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 19/10/23.
//

import SwiftUI
import SwiftData

struct SplashView: View {
    @Environment(EpisodesListViewModel.self) private var vm
    @Environment(\.modelContext) var context
    @Query(sort:\Episodio.id, order: .reverse) var episodes: [Episodio]
    
    @Binding var navigationState: NavigationState
    var body: some View {
        ZStack {
            VStack(spacing: 150){
                Image("splash")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .brightness(0.15)
                    .shadow(color: .clear1, radius: 5, x: 5, y: 5)
                    .overlay(Circle().stroke(lineWidth: 50).foregroundStyle(Color.clear1.opacity(0.5)).blur(radius: 10))
                
                Text("Podcast \n\n Próxima Parada Swift")
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
        .onAppear {
            Task {
                let epDescargados = await vm.fetchEpisodes(episodes)
                
                for episode in epDescargados {
                    if !episodes.contains(where: { $0.id == episode.id }) {
                        context.insert(episode)
                    }
                }
                try await Task.sleep(for: .seconds(1))
                navigationState = .episodes
            }
        }
    }
        
}

#Preview {
    let container = ModelContainer.previewContainer
    for e in Episodio.previewTenEpisodes {
        container.mainContext.insert(e)
    }
    return SplashView(navigationState: .constant(.splash))
        .environment(EpisodesListViewModel())
        .modelContainer(container)
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
