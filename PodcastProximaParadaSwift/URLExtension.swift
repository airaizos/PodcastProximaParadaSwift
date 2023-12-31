//
//  URLExtension.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 10/10/23.
//

import Foundation


extension URL {
    static func audioURL(episode: Episodio) -> URL {
        URL.documentsDirectory.appendingPathComponent("\(episode.id).mp3", conformingTo: .mp3)
    }
}
