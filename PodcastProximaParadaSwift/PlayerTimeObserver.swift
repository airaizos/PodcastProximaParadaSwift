//
//  PlayerTimeObserver.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 17/10/23.
//

import Foundation
import AVFoundation
import Combine

/**
 Actualiza el avance de la reproducción en curso
 
 */
final class PlayerTimeObserver {
    let publisher =  PassthroughSubject<TimeInterval,Never>()
    
    private weak var player: AVPlayer?
    private var timeObservation: Any?
    private var paused = false
    
    init(player: AVPlayer) {
        self.player = player
        
        timeObservation = player.addPeriodicTimeObserver(
            forInterval: CMTime(
                seconds: 0.5,
                preferredTimescale: 600),
            queue: nil) { [weak self] time in
            guard let self = self else { return }
            
            guard !self.paused else { return }
            self.publisher.send(time.seconds)
        }
    }
    
    deinit {
        if let player = player, let observer = timeObservation {
            player.removeTimeObserver(observer)
        }
    }
    
    func pause(_ pause: Bool){
        paused = pause
    }
}


