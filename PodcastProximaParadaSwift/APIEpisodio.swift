//
//  APIEpisodio.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 11/10/23.
//

import Foundation

struct APIEpisodio: Codable {
    let id: Int
    let title: Rendered
    let categories: [Int]
    let content: Rendered
}


extension APIEpisodio {
    
    var categoriesString: String {
        categories.reduce("") { "\($0)-\($1)" }
    }
    var episode: Episodio{
        Episodio(id: id, title: title.rendered, content: content.rendered, categories: categories, categoriesString:  categoriesString)
    }
}
