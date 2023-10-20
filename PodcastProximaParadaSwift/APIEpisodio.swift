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
    let link: URL
    let date: Date
}


extension APIEpisodio {
    
    var categoriesString: String {
        categories.reduce("") { "\($0)-\($1)" }
    }
    var episodio: Episodio {
        Episodio(id: id, title: title.rendered, content: content.rendered, categories: categories, categoriesString: categoriesString, link: link, date: date)
    }
}
