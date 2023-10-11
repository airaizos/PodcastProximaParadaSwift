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

    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ListView(sort: sortOrder,searchString: searchText)
                .searchable(text: $searchText)
            .navigationDestination(for: Episodio.self) { value in
                EpisodeDetailView(vm: DetailEpisodeViewModel(episode: value))
                  
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
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Episodio.self, configurations: config)
    for i in 1..<10 {
        let episode = Episodio(id: i, title: "Episodio No: \(i)", content: "Contenido del episodio \(i) \n Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod justo in ligula lacinia, in elementum libero iaculis. Duis rhoncus, felis nec aliquam consectetur, felis elit tincidunt libero, sit amet hendrerit felis lectus eget libero. Nulla facilisi. Praesent aliquam, augue eget porttitor blandit, mauris nisi tincidunt erat, ac ultricies orci elit nec quam. Fusce in lacinia ante, et rhoncus dui. Curabitur eget risus dui. Nulla ut libero id libero euismod auctor vel eget libero. Nulla nec tortor quis arcu sodales bibendum ut ac urna. Etiam et arcu auctor, efficitur ex ut, varius turpis. Proin quis odio eu sapien efficitur tincidunt non non justo. Aenean id tellus vel odio pellentesque efficitur at nec purus. ", categories: [2,3,4])
        container.mainContext.insert(episode)
    }

   return EpisodesListView()
        .modelContainer(container)
}
