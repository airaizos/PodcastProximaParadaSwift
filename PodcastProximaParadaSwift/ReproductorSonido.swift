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
    
    let network: Network
    let fileManager: FileManager
   
    init(network: Network = Network(), fileManager: FileManager = FileManager.default) {
        self.network = network
        self.fileManager = fileManager
    }
    
    let engine = AVAudioEngine()
    let speedControl = AVAudioUnitVarispeed()
    let pitchControl = AVAudioUnitTimePitch()
    
    func fetchAudio(from episode: Episodio) async throws -> Data {
        if let audioURL = try await network.fetchURL(episode) {
            do {
               return  try Data(contentsOf: audioURL)
            } catch {
                throw NSError(domain: "<< DATA: fetchAudio(from episode: Episodio) ", code: 0)
            }
        }
        throw NSError(domain: "<< URL: fetchAudio(from episode: Episodio) ", code: 1)
    }
    
    @discardableResult
    func saveAudioData(from episode: Episodio) async throws -> Bool {
        let audioFile = "\(episode.id).mp3"
        
        let data = try await fetchAudio(from: episode)
        if !fileManager.fileExists(atPath: "\(episode.id).mp3") {
            do {
                try data.write(to: .documentsDirectory.appendingPathComponent(audioFile, conformingTo: .audio))
                return true
            } catch {
                throw NSError(domain: "saveAudioData(from episode: Episodio)", code: 0)
            }
        } else { return false }
    }
    
    func playFromEngineNOFUNCIONA(_ episode: Episodio) async throws {
        let audioFile = "\(episode.id).mp3"
        do {

            let audioURL = URL.documentsDirectory.appendingPathComponent(audioFile, conformingTo: .mp3)
            print("<<\(audioURL)")
            if !fileManager.fileExists(atPath: audioFile) {
                //descargar
               try await saveAudioData(from: episode)
            }
            
            let file = try AVAudioFile(forReading: audioURL)
            
            let audioPlayer = AVAudioPlayerNode()
            
            engine.attach(audioPlayer)
            engine.attach(pitchControl)
            engine.attach(speedControl)
            
            engine.connect(audioPlayer, to: speedControl, format: nil)
            engine.connect(speedControl, to: pitchControl, format: nil)
            engine.connect(pitchControl, to: engine.mainMixerNode, format: nil)
            
            await audioPlayer.scheduleFile(file, at: nil)
            
            try engine.start()
            audioPlayer.play()
            //Thread 17: "player started when in a disconnected state"
            
          
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
    
    
    func isPlaying() -> Bool {
        player?.isPlaying ?? false
        
    }
    
    func pause() {
        player?.pause()
    }
    
    func playFromEngine(_ episode: Episodio) throws {
        let audioFile = "\(episode.id).mp3"
       
     let audioURL = URL.documentsDirectory.appendingPathComponent(audioFile, conformingTo: .mp3)
        do {
            let data = try Data(contentsOf: audioURL)
            
            player = try AVAudioPlayer(data: data)
        
            player?.prepareToPlay()
            player?.play()
        } catch  {
            throw NSError(domain: " playFrom(_ url: URL)", code: 1)
        }
    }
}
