//
//  PlayerItemObserver.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 17/10/23.
//

import Foundation
import Combine
import AVFoundation

/**
 Actualiza que se esté reproduciendo algún item
 */
final class PlayerItemObserver {
    let publisher = PassthroughSubject<Bool,Never>()
    
    private var itemObservation: NSKeyValueObservation?
    
    init(player: AVPlayer) {
        itemObservation =  player.observe(\.currentItem) { [weak self] player, change in
            guard let self = self else { return }
            
            self.publisher.send(player.currentItem != nil)
        }
    }
    
    deinit {
        if let observer = itemObservation {
            observer.invalidate()
        }
    }
    
}
