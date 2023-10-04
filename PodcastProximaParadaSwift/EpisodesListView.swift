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
                    NavigationLink(value: episode) {
                        VStack(alignment: .leading) {
                          
                            Text(episode.title)
                                .font(.headline)
                            HStack{
                         
                                ZStack {
                                    Image(systemName: "hearingdevice.ear")
                                    Image(systemName: episode.played  ? "line.diagonal" : "")
                                        
                                }
                                .foregroundStyle(episode.played ? Color.green : Color.red)
                                Image(systemName: episode.favorite ? "heart" : "heart.slash")
                                    .foregroundStyle(episode.favorite ? Color.red : Color.gray)
                            }
                            Text(episode.content)
                                .lineLimit(10)
                                .font(.caption2)
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationDestination(for: Episodio.self) { value in
                EpisodeDetailView(episode: value)
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
                
                Button {
                    deleteAllItems()
                } label: {
                    Image(systemName: "trash")
                        .foregroundStyle(.red)
                }
            }
        }
    }
    
    func deleteItems(_ indexSet: IndexSet) {
        for index in indexSet {
            let item = episodes[index]
            context.delete(item)
        }
    }
    
    func deleteAllItems() {
        for episode in episodes {
            context.delete(episode)
        }
    }
}

#Preview {
    EpisodesListView()
}
