//
//  ReproductorSonido.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 5/10/23.
//

import Foundation
import AVFoundation

final class ReproductorSonido {
    var player: AVAudioPlayer?
    
    func playFrom(_ url: URL) throws {
        do {
            let data = try Data(contentsOf: url)
            
            player = try AVAudioPlayer(data: data)
        
            player?.prepareToPlay()
            player?.play()
        } catch  {
            throw NSError(domain: " playFrom(_ url: URL)", code: 1)
        }
    }
}
