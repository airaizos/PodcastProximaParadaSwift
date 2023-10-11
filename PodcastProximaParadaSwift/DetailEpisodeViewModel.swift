//
//  DetailEpisodeViewModel.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 5/10/23.
//

import Foundation
import AVFoundation

final class DetailEpisodeViewModel: ObservableObject {
    let network: Network
    var episode: Episodio
    
    var audioURL: URL { URL.audioURL(episode: episode) }
    
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
    @Published var duration: ClosedRange<Date> = Date()...Date().addingTimeInterval(0)
    
    init(episode: Episodio, network: Network = Network(), reproductor: ReproductorSonido = ReproductorSonido()) {
        self.episode = episode
        self.network = network
        self.reproductor = reproductor
    }

    func play(episode: Episodio) throws {
       
      try reproductor.playFromEngine(episode)
    }
    
    func pause(episode:Episodio)  {
        reproductor.pause()
     
    }
    
    func goSeconds(_ sec: Double) {
        // Avanza 15 sec o retrocede segundos
        
    }

    func duracionAudioSeconds() async throws -> TimeInterval {
        let asset = AVAsset(url: audioURL)
        do {
            let durationSec = try await CMTimeGetSeconds(asset.load(.duration))
            
            if !durationSec.isNaN {
                return durationSec
            } else {
                return 0
            }
        } catch {
            throw NSError(domain: "duracionAudio", code: 1)
        }
    }
    
    func duracionAudioClosedRange(seconds : TimeInterval) -> ClosedRange<Date> {
        let inicio = Date()
        let fin = inicio.addingTimeInterval(seconds)
        return inicio...fin
    }
    
    func getEpisodeTimeInterval() async -> ClosedRange<Date> {
        do {
            let seconds = try await duracionAudioSeconds()
            return duracionAudioClosedRange(seconds: seconds)
        } catch {
            return Date()...Date().addingTimeInterval(0)
        }
    }
    
    
    func getEpisodeCurrent() -> String {
        let asset = AVAsset(url: audioURL)
        return ""
    }
}
