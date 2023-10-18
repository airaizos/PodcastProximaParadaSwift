//
//  DetailEpisodeViewModel.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 5/10/23.
//

import Foundation
import AVFoundation

/**
 ViewModel de la vista del detalle del Episodio al que se navega pasándole el parámetro `episode`
 
 */

final class DetailEpisodeViewModel: ObservableObject {
    let network: Network
    var episode: Episodio
    let fileManager: FileManager
    
    var audioURL: URL { URL.audioURL(episode: episode) }
    
    private let rates: [Float] = [1,1.1,1.2,1.3,1.5,1.75,2]
    
    @Published var stepRate = 0
    @Published var rate: Float = 1.0
    @Published var isPlaying: Bool = false
    @Published var duration: ClosedRange<Date> = Date()...Date().addingTimeInterval(0)
    
    init(episode: Episodio, network: Network = Network(), fileManager: FileManager = FileManager.default) {
        self.episode = episode
        self.network = network
        self.fileManager = fileManager
    }
    
    func changeRate(up: Bool) {
        if up && stepRate < rates.count-1 {
            
            stepRate += 1
            rate = rates[stepRate]
        } else if !up && stepRate >= 0 {
            stepRate -= 1
            rate = rates[stepRate]
        }
    }
    
    func isAudioEpisodeDownloaded() -> Bool {
        fileManager.fileExists(atPath: audioURL.path()) ? true : false
    }
    
    /// Descarga de la red el data del audio del episodio
    private func fetchAudio(from episode: Episodio) async throws -> Data {
        if let audioURL = try await network.fetchURL(episode) {
            do {
               return try Data(contentsOf: audioURL)
            } catch {
                throw NSError(domain: "<< DATA: fetchAudio(from episode: Episodio) ", code: 0)
            }
        }
        throw NSError(domain: "<< URL: fetchAudio(from episode: Episodio) ", code: 1)
    }

    
    /// Guarda el audio del *episodio* si es que no está ya descargado en la carpeta de `documentsDirectory`
    @discardableResult
    func saveAudioData() async throws -> Bool {
        
        let data = try await fetchAudio(from: episode)
        if !fileManager.fileExists(atPath: audioURL.absoluteString) {
            do {
                try data.write(to: audioURL)
                return true
            } catch {
                throw NSError(domain: "saveAudioData(from episode: Episodio)", code: 0)
            }
        } else { return false }
    }
}

enum AudioRate:String,CaseIterable {
    case x0_9 = "0.9x", x1_0 = "1x", x1_1 = "1.1x", x1_25 = "1.25x", x1_50 = "1.5x", x1_75 = "1.75x", x2_0  = "2x"
    
    var selected: Float {
        switch self {
        case .x0_9: 0.9
        case .x1_0: 1.0
        case .x1_1: 1.1
        case .x1_25: 1.25
        case .x1_50: 1.50
        case .x1_75: 1.75
        case .x2_0: 2.0
        }
    }
    
    var id: Self {
        self
    }

}


