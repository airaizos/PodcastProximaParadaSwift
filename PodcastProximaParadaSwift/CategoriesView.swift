//
//  CategoriesView.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 11/10/23.
//

import SwiftData
import SwiftUI

struct CategoriesView: View {
    @Environment(\.modelContext) var context
    @Query(filter: #Predicate { $0.id != 41 },sort: \PostCategory.name) var categories: [PostCategory]
    @Query(filter: #Predicate<Episodio> { $0.title.contains("Episodio") },sort:\Episodio.id, order:.reverse) var episodios: [Episodio]
    
    @StateObject var vm = CategoriesViewModel()
    var columns:[GridItem] = [GridItem(.fixed(50))]
    @State private var sortOrder = SortDescriptor(\Episodio.id)
    @State private var searchText = ""
    @State private var episodePredicate = #Predicate<Episodio> { [3].contains($0.categories) }
    
    @State var showEpisodes = false
    
    var body: some View {
        VStack{
            Button{
                Task {
                    let categories = try await vm.fetchCategories()
                    for category in categories {
                        context.insert(category)
                    }
                }
            } label: {
                ZStack{
                    Image("episodes")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .zIndex(1)
                    Circle().stroke(lineWidth: 2).blur(radius: 7)
                        .zIndex(0)
                }
            }
            .disabled(!categories.isEmpty)
            .frame(width: 150)
            Text("Categorías Episodios")
                .font(.largeTitle)
                .bold()
            ScrollView(.horizontal) {
                LazyHGrid(rows: columns,alignment: .center, spacing: 20) {
                    ForEach(categories) { category in
                        Button {
                            showEpisodes.toggle()
                        } label: {
                            ZStack{
                                VStack {
                                    Text(category.name == "episodios" ? "Todos" : category.name)
                                        .font(.subheadline.bold())
                                    Text("\(category.count)")
                                        .font(.callout)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color.black)
                        
                        
                    }
                   
                    
                }

            }
            .frame(height: 60)
            List(episodios) { episodio in
               EpisodeCellView(episode: episodio)
            }
            .listStyle(.inset)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let schema = Schema([
        Episodio.self,
        PostCategory.self
    ])
    let container = try! ModelContainer(for: schema, configurations: config)
    for i in 1..<10 {
        let episode = Episodio(id: i, title: "Episodio No: \(i)", content: "Contenido del episodio \(i) \n Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod justo in ligula lacinia, in elementum libero iaculis. Duis rhoncus, felis nec aliquam consectetur, felis elit tincidunt libero, sit amet hendrerit felis lectus eget libero. Nulla facilisi. Praesent aliquam, augue eget porttitor blandit, mauris nisi tincidunt erat, ac ultricies orci elit nec quam. Fusce in lacinia ante, et rhoncus dui. Curabitur eget risus dui. Nulla ut libero id libero euismod auctor vel eget libero. Nulla nec tortor quis arcu sodales bibendum ut ac urna. Etiam et arcu auctor, efficitur ex ut, varius turpis. Proin quis odio eu sapien efficitur tincidunt non non justo. Aenean id tellus vel odio pellentesque efficitur at nec purus. ", categories: Array(1..<i))
        episode.played = i % 3 == 0
        episode.favorite = i % 2 == 0
        
        container.mainContext.insert(episode)
    }

    return CategoriesView(vm:CategoriesViewModelMock())
        .modelContainer(container)
}

final class CategoriesViewModelMock: CategoriesViewModel {
    override func fetchCategories() async throws -> [PostCategory] {
        [PostCategory(id: 1, name: "Analogías", count: 3),PostCategory(id: 3, name: "episodios", count: 50),PostCategory(id: 4, name: "Repositorios", count: 3)]
    }
}

