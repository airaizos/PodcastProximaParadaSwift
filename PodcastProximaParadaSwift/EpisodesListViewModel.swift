//
//  EpisodesListViewModel.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 4/10/23.
//

import Foundation
import AVFoundation

final class EpisodesListViewModel: ObservableObject {
    let network: Network
    let reproductor: ReproductorSonido
    
    init(network: Network = Network(), reproductor: ReproductorSonido = ReproductorSonido()) {
        self.network = network
        self.reproductor = reproductor
    }
    
    func fetchEpisodes() async throws -> [Episodio] {
        var episodios: [Episodio] = []
        
        let apiEpisodios = try await network.fetchJson(url: network.urls.episodes, type: [APIEpisodio].self)
        
        for epi in apiEpisodios {
            
            if let data = epi.content.rendered.data(using: .isoLatin1) ?? epi.content.rendered.data(using: .utf8),
               let attributedString = try? AttributedString.init(NSAttributedString(data:data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)) {
                let content = attributedString
                
                episodios.append(Episodio(id: epi.id, title: epi.title.rendered, content: String(content.characters)))
            }
        }
        return episodios
    }
    
    func play(episode: Episodio) async throws {
        try await reproductor.playFromEngine(episode)
    }
    
    
   
    
}
