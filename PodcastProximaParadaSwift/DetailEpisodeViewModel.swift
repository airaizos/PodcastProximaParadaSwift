//
//  DetailEpisodeViewModel.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 5/10/23.
//

import Foundation


final class DetailEpisodeViewModel: ObservableObject {
    let network: Network
    var episode: Episodio
    
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
    
    @Published var isPlaying: Bool = false
    
    init(episode: Episodio, network: Network = Network(), reproductor: ReproductorSonido = ReproductorSonido()) {
        self.episode = episode
        self.network = network
        self.reproductor = reproductor
    }

    func play(episode: Episodio) async throws {
        isPlaying.toggle()
      try await reproductor.playFromEngine(episode)
    }
    
    func pause(episode:Episodio)  {
        reproductor.pause()
        isPlaying.toggle()
    }
    
    
    
}
