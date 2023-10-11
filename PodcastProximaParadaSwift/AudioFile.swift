//
//  AudioFile.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 11/10/23.
//

import Foundation


struct AudioFile: Codable {
    let downloaded: Bool
    let pathAudio: String
    let timeInterval: TimeInterval
    var duration: Duration  {
        .seconds(timeInterval)
    }
}
