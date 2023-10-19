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
    @ObservedObject var vm: EpisodesListViewModel
    @State private var sortOrder = SortDescriptor(\Episodio.id, order: .reverse)
    @State private var searchText = ""
    @AppStorage("ORDER") private var orderUp = true
    
    var body: some View {
        NavigationStack {
            ZStack{
                ListView(sort: sortOrder,searchString: searchText)
                    .searchable(text: $searchText)
                    .navigationDestination(for: Episodio.self) { value in
                        EpisodeDetailView(vm: DetailEpisodeViewModel(episode: value))
                    }
            }
            .navigationTitle("\(episodes.count) Episodios")
            .toolbar {
                    Button {
                        Task {
                            let epDescargados = try await vm.fetchEpisodes(episodes)
                          
                            for episode in epDescargados {
                                if !episodes.contains(where: { $0.id == episode.id }) {
                                    context.insert(episode)
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                    
                    .onChange(of: sortOrder) { _,_ in
                        orderUp.toggle()
                    }
                   
                
                Menu("Ordenar", systemImage: orderUp ? "arrow.up" : "arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("↑")
                            .tag(SortDescriptor(\Episodio.id,order: .forward))
                        Text("↓")
                            .tag(SortDescriptor(\Episodio.id, order: .reverse))
                    }
                }
               
                    Button {
                        deleteAllItems()
                    } label: {
                        Image(systemName: "trash")
                            .foregroundStyle(.red)
                    }
                Divider()
                    .background(Color.clear1)
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
    let container = ModelContainer.previewContainer
    for e in Episodio.previewTenEpisodes {
        container.mainContext.insert(e)
    }
    return EpisodesListView(vm: EpisodesListViewModel())
        .modelContainer(container)
}
