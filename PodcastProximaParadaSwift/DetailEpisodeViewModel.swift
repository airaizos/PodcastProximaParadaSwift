//
//  DetailEpisodeViewModel.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 5/10/23.
//

import Foundation


final class DetailEpisodeViewModel: ObservableObject {
    let network: Network
    
    let reproductor: ReproductorSonido
    @Published var pitch:Float = 0.0 {
        didSet {
            reproductor.controlPitch(pitch)
        }
    }
    @Published var speed:Float = 1 {
        didSet {
            reproductor.speedControl(speed)
        }
    }
    
    init(network: Network = Network(), reproductor: ReproductorSonido = ReproductorSonido()) {
        self.network = network
        self.reproductor = reproductor
    }
    
    func fetchURL(_ episode: Episodio) async throws -> URL? {
        let url = URL.episodeId(episode.id)
        
       let audioEpisodio = try await network.fetchJson(url: url, type: AudioEpisodio.self)
        
        return audioEpisodio.audioURL
    }
    
    func play(episode: Episodio) async throws {
        let url = try await fetchURL(episode)
        guard let url else { return }

        try reproductor.playFromEngine(url)
        
    }
    
}
