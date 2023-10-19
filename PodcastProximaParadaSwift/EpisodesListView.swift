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
    @StateObject var vm = EpisodesListViewModel()
    @State private var sortOrder = SortDescriptor(\Episodio.id, order: .forward)
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ZStack{
                ListView(sort: sortOrder,searchString: searchText)
                   // .searchable(text: $searchText)
                    .navigationDestination(for: Episodio.self) { value in
                        EpisodeDetailView(vm: DetailEpisodeViewModel(episode: value))
                    }
            }
            .navigationTitle("Episodes")
            .toolbar {
                    Button {
                        Task {
                            let epDescargados = try await vm.fetchEpisodes()
                          
                            for episode in epDescargados {
                                if !episodes.contains(where: { $0.id == episode.id }) {
                                    context.insert(episode)
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                    
                    //.disabled(!episodes.isEmpty)
                    

                Menu("Ordenar", systemImage: "arrow.up.arrow.down") {
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
   return EpisodesListView()
        .modelContainer(container)
}
