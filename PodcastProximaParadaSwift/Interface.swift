//
//  Interface.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 4/10/23.
//

import Foundation

extension URL {
    static let episodes = URL(string:"https://proximaparadaswift.dev/wp-json/wp/v2/posts?per_page=10")!
    
    static func episodeId(_ id: Int) -> URL { URL(string:"https://proximaparadaswift.dev/wp-json/wp/v2/posts/\(id)")!
    }

    static let categories = URL(string:"https://proximaparadaswift.dev/wp-json/wp/v2/categories")!
    
    static func pageId(_ id: Int) -> URL  { URL(string: "https://www.proximaparadaswift.dev/wp-json/wp/v2/pages/\(id)")!}
    
    static let perfilPhoto = URL(string: "https://www.proximaparadaswift.dev/wp-content/uploads/2023/09/perfil-Adrian.png")
    
    static let aboutMe = URL(string: "https://www.proximaparadaswift.dev/wp-json/wp/v2/pages/556")!
    
    static let enlaces = URL(string: "https://www.proximaparadaswift.dev/wp-json/wp/v2/pages/229")!
}
