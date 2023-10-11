//
//  CategoriesViewModel.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 11/10/23.
//

import Foundation

class CategoriesViewModel: ObservableObject {
    let network: Network
    
    init(network: Network = Network()) {
        self.network = network
    }
    
    func fetchCategories() async throws -> [PostCategory] {
       let apiCategories = try await network.fetchJson(url: URL.categoriesURL, type: [APIPostCategory].self)
        
        var categories = [PostCategory]()
        for category in apiCategories {
            categories.append(PostCategory(id:category.id, name: category.name, count: category.count))
        }
        return categories
    }
}
