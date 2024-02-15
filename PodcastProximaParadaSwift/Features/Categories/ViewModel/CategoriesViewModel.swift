//
//  CategoriesViewModel.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 11/10/23.
//

import Foundation
import Observation

@Observable
class CategoriesViewModel {
    let network: Network
    
    init(network: Network = Network()) {
        self.network = network
    }
    
    func fetchCategories() async  -> [PostCategory] {
        await network.fetchCategories()
    }
}
