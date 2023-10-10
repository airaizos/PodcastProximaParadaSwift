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
    @Query(filter:#Predicate{ $0.categories.contains(3)}, sort:\Episodio.id ,order:.reverse ) var episodes: [Episodio]
    
    let filter = #Predicate { $0}
    var body: some View {
        List {
            ForEach(episodes) { episode in
                NavigationLink(value: episode) {
                    EpisodeCellView(episode: episode)
                    }
            }
            .onDelete(perform: deleteItems)
        }
    }
    
    func deleteItems(_ indexSet: IndexSet) {
        for index in indexSet {
            let item = episodes[index]
            context.delete(item)
        }
    }
    //¿Como añado un array de predicates?
    init(sort: SortDescriptor<Episodio>, searchString: String) {
        _episodes = Query(filter: #Predicate {
            if searchString.isEmpty {
                return true
            } else {
               return $0.title.localizedStandardContains(searchString) || $0.content.localizedStandardContains(searchString)
            }
            
        },sort:[sort])
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Episodio.self, configurations: config)
    for i in 1..<10 {
        let episode = Episodio(id: i, title: "Episodio No: \(i)", content: "Contenido del episodio \(i) \n Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod justo in ligula lacinia, in elementum libero iaculis. Duis rhoncus, felis nec aliquam consectetur, felis elit tincidunt libero, sit amet hendrerit felis lectus eget libero. Nulla facilisi. Praesent aliquam, augue eget porttitor blandit, mauris nisi tincidunt erat, ac ultricies orci elit nec quam. Fusce in lacinia ante, et rhoncus dui. Curabitur eget risus dui. Nulla ut libero id libero euismod auctor vel eget libero. Nulla nec tortor quis arcu sodales bibendum ut ac urna. Etiam et arcu auctor, efficitur ex ut, varius turpis. Proin quis odio eu sapien efficitur tincidunt non non justo. Aenean id tellus vel odio pellentesque efficitur at nec purus. ", categories: [2,3,4])
        episode.played = i % 3 == 0
        episode.favorite = i % 2 == 0
        
        container.mainContext.insert(episode)
    }
    
    return NavigationStack {   ListView(sort: SortDescriptor(\Episodio.title), searchString: "")
            .modelContainer(container)
    }
}



struct EpisodeCellView: View {
    var episode: Episodio
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text("\(episode.id)")
                    .font(.subheadline)
                    .foregroundStyle(Color.secondary)
                Text(episode.title)
                    .font(.headline)
            }
            ButtonsStatusHStackView(played: episode.played, favorite: episode.favorite, downloaded: episode.audio.downloaded)
            
            
            Text(episode.content)
                .lineLimit(2)
                .font(.caption2)
            Text("\(episode.audio.duration.formatted(.time(pattern: .minuteSecond)))")
        }
    }
}
