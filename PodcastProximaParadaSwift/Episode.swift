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
    let categories: [Int]
    var played: Bool = false
    var favorite: Bool = false
    var comments: String = ""
    var audio: AudioFile = AudioFile(downloaded: false, pathAudio: "", timeInterval: 1445)
    
    init(id: Int = 0, title: String = "", content: String = "", categories: [Int] = []) {
        self.id = id
        self.title = title
        self.content = content
        self.categories = categories
    }
}

struct APIEpisodio: Codable {
    let id: Int
    let title: Rendered
    let categories: [Int]
    let content: Rendered
    
  
}

struct Rendered: Codable {
    let rendered: String
}


struct AudioFile: Codable {
    let downloaded: Bool
    let pathAudio: String
    let timeInterval: TimeInterval
    var duration: Duration  {
        .seconds(timeInterval)
    }
    
    
    
}
