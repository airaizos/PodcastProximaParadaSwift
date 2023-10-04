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

