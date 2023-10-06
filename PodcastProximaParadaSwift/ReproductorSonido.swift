//
//  ReproductorSonido.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 5/10/23.
//

import SwiftUI
import AVFoundation

final class ReproductorSonido {
    var player: AVAudioPlayer?
    private var pitch = 0.0
    private var rate = 1
    
    let engine = AVAudioEngine()
    let speedControl = AVAudioUnitVarispeed()
    let pitchControl = AVAudioUnitTimePitch()
    
    
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
    
    func playFromEngine(_ url: URL) throws {
        do {
            
            // TODO: - DESCARGAR EL AUDIO
            let data = try Data(contentsOf: url)
            let documentsURL = URL.documentsDirectory.appending(path: "audio")
            try data.write(to: documentsURL)
           
            let file = try AVAudioFile(forReading: documentsURL)
            
            let audioPlayer = AVAudioPlayerNode()
            
            engine.attach(audioPlayer)
            engine.attach(pitchControl)
            engine.attach(speedControl)
            
            engine.connect(audioPlayer, to: speedControl, format: nil)
            engine.connect(speedControl, to: pitchControl, format: nil)
            engine.connect(pitchControl, to: engine.mainMixerNode, format: nil)
            
            audioPlayer.scheduleFile(file, at: nil)
            
            try engine.start()
            audioPlayer.play()
        } catch  {
            throw NSError(domain: " playFrom(_ url: URL)", code: 1)
        }
    }
    
    //The default value is 1.0. The range of supported values is 1/32 to 32.0.
    func controlPitch(_ step: Float) {
        pitchControl.pitch = 50 * step
    }
    
   // The range of values is 0.25 to 4.0
    func speedControl(_ step: Float) {
        speedControl.rate = step
    }
}
