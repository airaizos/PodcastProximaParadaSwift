//
//  PlayerDurationObserver.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 17/10/23.
//

import Foundation
import Combine
import AVFoundation

/**
 Muestra la duración de un audio
 */
final class PlayerDurationObserver {
    let publisher = PassthroughSubject<TimeInterval,Never>()
    
    private var cancelable: AnyCancellable?
    
    init(player: AVPlayer) {
        let durationKeyPath: KeyPath<AVPlayer, CMTime?> = \.currentItem?.duration
        cancelable = player.publisher(for: durationKeyPath).sink { duration in
            guard let duration = duration else { return }
            guard duration.isNumeric else { return }
            self.publisher.send(duration.seconds)
            
        }
    }
    
    deinit {
        cancelable?.cancel()
    }
    
}
