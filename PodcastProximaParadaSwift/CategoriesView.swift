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
        $0.categoriesString.contains("3")
    },sort:\Episodio.id, order:.reverse) var episodes: [Episodio]
    
    var columns:[GridItem] = [GridItem(.fixed(50))]
    
    @State var selectedCategory = 3
    @State private var filter = #Predicate<Episodio> { $0.id != 41 }
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack {
                    CategoriesButtonTitleView()
                    Text("Categorías Episodios")
                        .font(.largeTitle)
                        .bold()
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: columns,alignment: .center, spacing: 20) {
                            ForEach(categories) { category in
                                Button {
                                    selectedCategory = category.id
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
                    
                    ListViewPredicate(filter: filter, sort: SortDescriptor(\Episodio.id, order: .forward), searchString: "")
                        .listStyle(.inset)
                    Divider()
                        .background(Color.clearest)
                }
                
                .navigationDestination(for: Episodio.self) { value in
                    EpisodeDetailView(vm: DetailEpisodeViewModel(episode: value))
                }
                .onChange(of: selectedCategory) { _,newValue in
                    
                    filter = #Predicate<Episodio> { $0.categoriesString.contains("\(newValue)")}
                }
                
                Color.clearest
                    .ignoresSafeArea()
                    .zIndex(-1)
            }
        }
    }
}

#Preview {
    let container = ModelContainer.previewContainer
    for e in Episodio.previewTenEpisodes {
        container.mainContext.insert(e)
    }
    return CategoriesView()
        .modelContainer(container)
}

final class CategoriesViewModelMock: CategoriesViewModel {
    override func fetchCategories() async throws -> [PostCategory] {
        [PostCategory(id: 1, name: "Analogías", count: 3),PostCategory(id: 3, name: "episodios", count: 50),PostCategory(id: 4, name: "Repositorios", count: 3)]
    }
}


struct CategoriesButtonTitleView: View {
    @Environment(\.modelContext) var context
    @Query(filter: #Predicate { $0.id != 41 },sort: \PostCategory.name) var categories: [PostCategory]
    
    @StateObject var vm = CategoriesViewModel()
    var body: some View {
        Button {
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
    }
}
