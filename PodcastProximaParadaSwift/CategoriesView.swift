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
    @Query(filter: #Predicate<Episodio> {
        //filtrar los episodios
      //  $0.title.contains("Epi")
        $0.categoriesString.contains("9")
    },sort:\Episodio.id, order:.reverse) var episodios: [Episodio]
    
    @StateObject var vm = CategoriesViewModel()
    var columns:[GridItem] = [GridItem(.fixed(50))]
    @State private var sortOrder = SortDescriptor(\Episodio.id)
    @State private var searchText = ""
    @State private var episodePredicate = #Predicate<Episodio> { [3].contains($0.categories) }
    
    @State var showEpisodes = false
    
    var body: some View {
        ZStack{
            VStack{
                Button{
                    Task {
                        print(episodios.map { $0.categoriesString})
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
                            .tint(Color.gray)
                        }
                    }
                }
                .frame(height: 60)
                List(episodios) { episodio in
                    EpisodeCellView(episode: episodio, color: Color.clearest)
                }
                .listStyle(.inset)
                Divider()
                    .background(Color.clearest)
            }
            Color.clearest
                .ignoresSafeArea()
                .zIndex(-1)
        }
        }
}

#Preview {
    let container = ModelContainer.previewContainer
    for e in Episodio.previewTenEpisodes {
        container.mainContext.insert(e)
    }
    return CategoriesView(vm:CategoriesViewModelMock())
        .modelContainer(container)
}

final class CategoriesViewModelMock: CategoriesViewModel {
    override func fetchCategories() async throws -> [PostCategory] {
        [PostCategory(id: 1, name: "Analogías", count: 3),PostCategory(id: 3, name: "episodios", count: 50),PostCategory(id: 4, name: "Repositorios", count: 3)]
    }
}

