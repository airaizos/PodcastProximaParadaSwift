//
//  Interface.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 4/10/23.
//

import Foundation

/**
 Para más información sobre la [API de Wordpress](https://developer.wordpress.org/rest-api/)
 */
extension URL {
    
    // Posts
    
    static let episodes = URL(string:"https://proximaparadaswift.dev/wp-json/wp/v2/posts?per_page=100")!
    
    static let lastEpisode = URL(string:"https://proximaparadaswift.dev/wp-json/wp/v2/posts?per_page=1")!
    
    static func episodeId(_ id: Int) -> URL { URL(string:"https://proximaparadaswift.dev/wp-json/wp/v2/posts/\(id)")! }
    
    // Categories

    static let categories = URL(string:"https://proximaparadaswift.dev/wp-json/wp/v2/categories")!
    
   // Pages
    
    static let aboutMe = URL(string: "https://www.proximaparadaswift.dev/wp-json/wp/v2/pages/556")!
    
    static let enlaces = URL(string: "https://www.proximaparadaswift.dev/wp-json/wp/v2/pages/229")!
    
    static func pageId(_ id: Int) -> URL  { URL(string: "https://www.proximaparadaswift.dev/wp-json/wp/v2/pages/\(id)")! }
    
    // Images
    
    static let perfilPhoto = URL(string: "https://www.proximaparadaswift.dev/wp-content/uploads/2023/09/perfil-Adrian.png")
    
    static let logoSwift = URL(string: "https://www.proximaparadaswift.dev/wp-content/uploads/2023/09/swiftLogo.png")!
    
}
