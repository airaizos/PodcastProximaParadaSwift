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
    @Query(sort:\Episodio.id, order: .reverse) var episodes: [Episodio]
    @ObservedObject var vm = EpisodesListViewModel()
    @State private var sortOrder = SortDescriptor(\Episodio.title)
   // @State private var filter = #Predicate { $0 }
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ListView(sort: sortOrder,searchString: searchText)
                .searchable(text: $searchText)
            .navigationDestination(for: Episodio.self) { value in
                EpisodeDetailView(episode: value)
                  
            }
            
            .navigationTitle("Episodes")
            .toolbar {
           
                    Button {
                        Task {
                            let episodes = try await vm.fetchEpisodes()
                            for episode in episodes {
                                context.insert(episode)
                            }
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                    
                    .disabled(!episodes.isEmpty)
                    
                    Menu("Ordenar", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Núm")
                                .tag(SortDescriptor(\Episodio.id))
                            Text("Título")
                                .tag(SortDescriptor(\Episodio.title))
                            Text("Notas")
                                .tag(SortDescriptor(\Episodio.content))
                            
                        }
                    }
//                    Menu("Filtrar", systemImage: "cone") {
//                        Picker("Sort", selection: $filter) {
//                            Text("Favoritos")
//                                .tag(#Predicate{ $0.favorite })
//                            Text("Escuchados")
//                                .tag(#Predicate { $0.played })
//                        }
//                    }
                    Button {
                        deleteAllItems()
                    } label: {
                        Image(systemName: "trash")
                            .foregroundStyle(.red)
                    }
                
            }
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
