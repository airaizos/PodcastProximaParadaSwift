//
//  ReproductorControlsView.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 17/10/23.
//

import SwiftUI
import AVFoundation

/**
 Vista del Control de la reproducción del audio. Adelantar, barra de progreso y Retroceder
 */

struct ReproductorControlsView: View {
    let player: AVPlayer
    
    let timeObserver: PlayerTimeObserver
    let durationObserver: PlayerDurationObserver
    let itemObserver: PlayerItemObserver
    
    @State private var currentTime: TimeInterval = 0
    @State private var currentDuration: TimeInterval = 0
    @State private var state = PlaybackState.waitingForSelection
    
    var body: some View {
        HStack{
            Button {
                goSeconds()
            } label: {
                Image(systemName: "goforward.90")
                    .font(.title)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color.clearest,Color.pinkest)
                    
            }
            .frame(width: 44)
           
            Slider(value: $currentTime, in: 0...currentDuration, onEditingChanged: sliderEditingChanged, minimumValueLabel: Text("\(formatSecondsToHMS(currentTime))").font(.caption2).fontWeight(.light).foregroundStyle(Color.clear1), maximumValueLabel: Text("\(formatSecondsToHMS(currentDuration))").font(.caption2).fontWeight(.light).foregroundStyle(Color.clear1)) {
                Text("")
            }
            .disabled(state != .playing)
            
            Button {
                goSeconds(.init(seconds: -30, preferredTimescale: 600))
            } label: {
                Image(systemName: "gobackward.30")
                    .font(.title)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color.clearest,Color.pinkest)
            }
            .frame(width: 44)
        }
        .tint(Color.clearest)
        .background(Color.darkest)
        .onReceive(timeObserver.publisher) { time in
            self.currentTime = time
            if time > 0 {
                self.state = .playing
            }
        }
        
        .onReceive(durationObserver.publisher) { duration in
            self.currentDuration = duration
        }
        
        .onReceive(itemObserver.publisher)  { hasItem in
            self.state = hasItem ? .buffering : .waitingForSelection
            self.currentTime = 0
            self.currentDuration = 0
        }
    }
    
    private func sliderEditingChanged(editingStarted: Bool) {
        if editingStarted {
            timeObserver.pause(true)
            
        } else {
            state = .buffering
            let targetTime = CMTime(seconds: currentTime, preferredTimescale: 600)
            player.seek(to: targetTime) { _ in
                self.timeObserver.pause(false)
                self.state = .playing
            }
        }
    }
    
    private func goSeconds(_ seconds: CMTime = .init(seconds: 90, preferredTimescale: 600)) {
        state = .buffering
        let targetTime = CMTime(seconds: currentTime, preferredTimescale: 600)
        player.seek(to: targetTime + seconds) { _ in
            
            self.timeObserver.pause(false)
            self.state = .playing
        }
    }
    
}
