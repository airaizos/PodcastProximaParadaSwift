//
//  AudioEpisode.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 5/10/23.
//

import Foundation

struct AudioEpisodio: Codable {
    
    let content: Rendered
    var contenido: String {
        content.rendered
    }

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
