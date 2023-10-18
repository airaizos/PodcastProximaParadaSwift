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
    @State private var sortOrder = SortDescriptor(\Episodio.id)

    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ZStack{
                ListView(sort: sortOrder,searchString: searchText)
                    .searchable(text: $searchText)
                    .navigationDestination(for: Episodio.self) { value in
                        EpisodeDetailView(vm: DetailEpisodeViewModel(episode: value))
                        
                    }
               
            }
            .navigationTitle("Episodes")
            .toolbar {
           
                    Button {
                        Task {
                            let epDescargados = try await vm.fetchEpisodes()
                            print("ANTES",episodes.count)
                            for episode in epDescargados {
                                if !episodes.contains(where: { $0.id == episode.id }) {
                                    context.insert(episode)
                                }
                            }
                            print("DESPUÉS",episodes.count)
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                    
                    //.disabled(!episodes.isEmpty)
                    
                Menu("Ordenar", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Id")
                            .tag(SortDescriptor(\Episodio.id))
                        Text("Título")
                            .tag(SortDescriptor(\Episodio.title))
                    }
                }
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
    let container = ModelContainer.previewContainer
    for e in Episodio.previewTenEpisodes {
        container.mainContext.insert(e)
    }
   return EpisodesListView()
        .modelContainer(container)
}


enum SortEpisodes:Int {
    case idR = 1, idF = 2, titleR = 3, titleF = 4
    
    var order: SortDescriptor<Episodio> {
        switch self {
            
        case .idR: SortDescriptor(\Episodio.id)
        case .idF: SortDescriptor(\Episodio.id)
        case .titleR: SortDescriptor(\Episodio.title)
        case .titleF: SortDescriptor(\Episodio.title)
        }
    }
    
}
