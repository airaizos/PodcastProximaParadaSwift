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
