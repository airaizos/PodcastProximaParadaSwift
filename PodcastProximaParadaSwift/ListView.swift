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
    @Query() var episodes: [Episodio]
  
    var body: some View {
        ZStack{
            List {
                ForEach(episodes) { episode in
                    NavigationLink(value: episode) {
                        EpisodeCellView(vm: DetailEpisodeViewModel(episode: episode), color: Color.clear1)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(.inset)
            .background(Color.clear1)
            .scrollContentBackground(.hidden)
            Color.clear1
                .ignoresSafeArea()
                .zIndex(-1)
        }
    }
    
    func deleteItems(_ indexSet: IndexSet) {
        for index in indexSet {
            let item = episodes[index]
            context.delete(item)
        }
    }
    
   
    init(sort: SortDescriptor<Episodio>, searchString: String) {
     
        _episodes = Query(filter: #Predicate { episode in
           
            if searchString.isEmpty {
              return episode.categoriesString.contains("3")
            } else {
               return episode.categoriesString.contains("3") && episode.title.localizedStandardContains(searchString)
            }
           
        },sort:[sort])
    }
}

#Preview {
    let container = ModelContainer.previewContainer
    for e in Episodio.previewTenEpisodes {
        container.mainContext.insert(e)
    }
    
    return NavigationStack {   ListView(sort: SortDescriptor(\Episodio.id), searchString: "")
            .modelContainer(container)
    }
}




