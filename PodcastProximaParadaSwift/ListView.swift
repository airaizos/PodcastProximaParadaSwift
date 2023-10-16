//
//  ListView.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 4/10/23.
//
import SwiftData
import SwiftUI

struct ListView: View {
    @Environment(\.modelContext) var context
  //  @Query(filter:#Predicate{ $0.categories.contains(3)}, sort:\Episodio.id ,order:.reverse ) var episodes: [Episodio]
    @Query(filter:#Predicate<Episodio> { $0.id == 1 } ) var episodes: [Episodio]
  
    var body: some View {
        List {
            ForEach(episodes) { episode in
                NavigationLink(value: episode) {
                    EpisodeCellView(episode: episode)
                    }
            }
        
            .onDelete(perform: deleteItems)
        }
        .listStyle(.inset)
        .background(Color.clear1)
        .scrollContentBackground(.hidden)
    }
    
    func deleteItems(_ indexSet: IndexSet) {
        for index in indexSet {
            let item = episodes[index]
            context.delete(item)
        }
    }
    //¿Como añado un array de predicates?
    init(sort: SortDescriptor<Episodio>, searchString: String) {
     
        _episodes = Query(filter: #Predicate { episode in
           
           // episode.categories.contains(3) No funciona
            episode.title.contains("Episodio")
           
        },sort:[sort])
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Episodio.self, configurations: config)
    let episodies = Episodio.previewTenEpisodes
    for episode in episodies {
        container.mainContext.insert(episode)
    }

    return NavigationStack {   ListView(sort: SortDescriptor(\Episodio.title), searchString: "")
            .modelContainer(container)
    }
}




