//
//  Episode.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 4/10/23.
//

import Foundation

final class Episodio: Codable {
    let id: Int
    let title: Rendered
    let guid: Rendered
    let content: Rendered
    
    struct Rendered: Codable {
        let rendered: String
    }
}
