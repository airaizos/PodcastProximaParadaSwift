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
    @Query(sort: \PostCategory.name, order: .reverse) var categories: [PostCategory]
    
    @StateObject var vm = CategoriesViewModel()
    var body: some View {
        List(categories) { category in
            Text(category.name)
        }
        .safeAreaInset(edge: .top) {
            Button{
                Task {
                    let categories = try await vm.fetchCategories()
                    for category in categories {
                        context.insert(category)
                    }
                }
            } label: {
                Image(systemName: "arrow.clockwise")
            }
            .disabled(!categories.isEmpty)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: PostCategory.self, configurations: config)
   return CategoriesView(vm:CategoriesViewModelMock())
        .modelContainer(container)
}

final class CategoriesViewModelMock: CategoriesViewModel {
    override func fetchCategories() async throws -> [PostCategory] {
        [PostCategory(id: 1, name: "Analogías", count: 3),PostCategory(id: 3, name: "Episodio", count: 50),PostCategory(id: 4, name: "Repositorios", count: 3)]
    }
}
