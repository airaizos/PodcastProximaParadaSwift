//
//  ListView.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 4/10/23.
//
import SwiftData
import SwiftUI

struct ListViewPredicate: View {
    @Environment(\.modelContext) var context
    @Query(sort:\Episodio.id, order: .reverse) var episodes: [Episodio]
  
    var body: some View {
        ZStack{
            List {
                ForEach(episodes) { episode in
                    NavigationLink(value: episode) {
                        EpisodeCellView(vm: DetailEpisodeViewModel(episode: episode), color: Color.clearest)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(.inset)
            .background(Color.clear1)
            .scrollContentBackground(.hidden)
            Color.clearest
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
    
    init(filter: Predicate<Episodio> = #Predicate<Episodio> { $0.categoriesString.contains("3") },sort: SortDescriptor<Episodio>, searchString: String) {
        _episodes = Query(filter: filter,sort:[sort])
    }
}

#Preview {
    let container = ModelContainer.previewContainer
    for e in Episodio.previewTenEpisodes {
        container.mainContext.insert(e)
    }
    
    return NavigationStack {  ListViewPredicate(filter: #Predicate<Episodio> { $0.categoriesString.contains("3")}, sort: SortDescriptor(\Episodio.id), searchString: "")
            .modelContainer(container)
    }
}
