//
//  EpisodesListViewModel.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 4/10/23.
//

import Foundation


final class EpisodesListViewModel: ObservableObject {
    let network = Network()
    
    
    func fetchEpisodes() async throws -> [Episodio] {
        var episodios: [Episodio] = []
        
        let apiEpisodios = try await network.fetchJson(url: network.urls.episodes, type: [APIEpisodio].self)
        
        for epi in apiEpisodios {
            episodios.append(Episodio(id: epi.id, title: epi.title.rendered, content: epi.content.rendered))
        }
        
        return episodios
    }
}
