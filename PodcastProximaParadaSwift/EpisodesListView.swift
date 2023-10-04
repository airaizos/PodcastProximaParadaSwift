//
//  EpisodesListsView.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 4/10/23.
//

import SwiftData
import SwiftUI

struct EpisodesListView: View {
    @Environment(\.modelContext) var context
    @Query var episodes: [Episodio]
    @ObservedObject var vm = EpisodesListViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(episodes) { episode in
                    VStack(alignment: .leading) {
                        Text(episode.title)
                            .font(.headline)
                        Text(episode.content)
                            .lineLimit(3)
                            .font(.caption2)
                        
                    }
                }
            }
            .navigationTitle("Episodes")
            .toolbar {
                Button("Get Episodes") {
                    Task {
                        let episodes = try await vm.fetchEpisodes()
                        for episode in episodes {
                            context.insert(episode)
                        }
                    }
                }
                .disabled(!episodes.isEmpty)
            }
        }
    }
}

#Preview {
    EpisodesListView()
}
