//
//  Episode.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 4/10/23.
//

import Foundation
import SwiftData

@Model
final class Episodio {
    let id: Int
    let title: String
    let content: String
    var played: Bool = false
    var favorite: Bool = false
    var comments: String = ""
    
    init(id: Int = 0, title: String = "", content: String = "") {
        self.id = id
        self.title = title
        self.content = content
    }
    
}

struct APIEpisodio: Codable {
    let id: Int
    let title: Rendered
    let content: Rendered
    
    struct Rendered: Codable {
        let rendered: String
    }
}

struct AudioEpisodio: Codable {
    let contenido: String
    var audioURL: URL? {
        let patronInicial = "audio controls src=\""
        let patronFinal = "\"></audio>"
        let patron = "\(patronInicial)(.*?)\(patronFinal)"
        
        do {
            let regex = try Regex(patron)
            
            if let firstMatch = try regex.firstMatch(in: contenido) {
                let matchRange = firstMatch.range
                
                let urlString = String(contenido[matchRange])
                    .replacingOccurrences(of: patronInicial, with: "")
                    .replacingOccurrences(of: patronFinal, with: "")
                
                return URL(string: urlString)
            }
        } catch {
            return nil
        }
        
        return nil
    }
    
}
