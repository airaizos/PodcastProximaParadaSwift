//
//  EpisodesListViewModel.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 4/10/23.
//

import Foundation
import AVFoundation
import Observation
/**
 
 ViewModel de la vista del **listado** de episodios
 
 Las funciones será descargar los datos de la API de wordpress del podcast [Proxima Parada Swift](www.proximaparadaswift.dev)
 
 Necesita de la clase `Network` que es la que se encarga de la llamada a la red.
 
 **¿Debería reproducir el epsiodio desde aqui?**
 
 */
@Observable
final class EpisodesListViewModel {
    let network: Network
    
    init(network: Network = Network()) {
        self.network = network
    }
    
    func fetchEpisodes(_ episodes: [Episodio]) async -> [Episodio] {
        let lastEpisode = episodes.first?.id ?? 0
        
        do {
            let lastPublishedEpisode = try await network.fetchJson(url: .lastEpisode, type: [APIEpisodio].self)
            if let recentId = lastPublishedEpisode.first?.id, recentId > lastEpisode {
                
                return await network.fetchEpisodes()
            } else {
                return []
            }
        } catch {
            return []
        }
    }
}

