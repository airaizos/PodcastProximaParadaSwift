//
//  UpdateEpisodesViewModel.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 19/10/23.
//

import Foundation
import SwiftData


final class UpdateEpisodesViewModel: ObservableObject  {
    let network: Network
    
    init(network: Network = Network()) {
        self.network = network
    }

    func updateEpisodes(_ episodes: [Episodio]) async throws -> [Episodio] {
        guard let lastEpisode = episodes.first else { return [] }
            
        do {
            let lastPublishedEpisode = try await network.fetchJson(url: .lastPost, type: APIEpisodio.self)
            if lastPublishedEpisode.id > lastEpisode.id {
               
              return try await network.fetchEpisodes()
            } else {
                return []
            }
        } catch{
            return []
        }
    }

}
