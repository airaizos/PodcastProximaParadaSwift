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
    @Query(sort:\Episodio.id, order: .reverse) var episodes: [Episodio]
    
    let filter = #Predicate { $0}
    var body: some View {
        List {
            ForEach(episodes) { episode in
                NavigationLink(value: episode) {
                    VStack(alignment: .leading) {
                        HStack{
                            Text("\(episode.id)")
                                .font(.subheadline)
                                .foregroundStyle(Color.secondary)
                            Text(episode.title)
                                .font(.headline)
                        }
                        HStack{
                     
                            ZStack {
                                Image(systemName: "hearingdevice.ear")
                                Image(systemName: episode.played  ? "line.diagonal" : "")
                                    
                            }
                            .foregroundStyle(episode.played ? Color.green : Color.red)
                            Image(systemName: episode.favorite ? "heart" : "heart.slash")
                                .foregroundStyle(episode.favorite ? Color.red : Color.gray)
                        }
                        Text(episode.comments)
                            .lineLimit(3)
                            .font(.callout)
                            .foregroundStyle(Color.secondary)
                        
                        Text(episode.content)
                            .lineLimit(10)
                            .font(.caption2)
                    }
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
    ListView(sort: SortDescriptor(\Episodio.title), searchString: "")
}
