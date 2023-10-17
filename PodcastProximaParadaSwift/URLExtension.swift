//
//  URLExtension.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 10/10/23.
//

import Foundation


extension URL {
    static func audioURL(episode: Episodio) -> URL {
      //  URL.documentsDirectory.appendingPathExtension("\(episode.id).mp3")
        URL.documentsDirectory.appendingPathComponent("\(episode.id).mp3", conformingTo: .mp3)
    }
    
    static func postsByCategory(_ category:Int) -> URL {
        URL(string:"https://www.proximaparadaswift.dev/wp-json/wp/v2/posts?categories=\(category)")!
    }
    
    static var categoriesURL: URL {
        URL(string: "https://proximaparadaswift.dev/wp-json/wp/v2/categories")!
    }
}
