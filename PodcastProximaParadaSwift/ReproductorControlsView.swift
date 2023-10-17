//
//  ReproductorControlsView.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 17/10/23.
//

import SwiftUI
import AVFoundation

struct ReproductorControlsView: View {
    let player: AVPlayer
    
    let timeObserver: PlayerTimeObserver
    let durationObserver: PlayerDurationObserver
    let itemObserver: PlayerItemObserver
    
    @State private var currentTime: TimeInterval = 0
    @State private var currentDuration: TimeInterval = 0
    @State private var state = PlaybackState.waitingForSelection
    
    var body: some View {
        
        
        
        Slider(value: $currentTime, in: 0...currentDuration, onEditingChanged: sliderEditingChanged, minimumValueLabel: Text("\(formatSecondsToHMS(currentTime))"), maximumValueLabel: Text("\(formatSecondsToHMS(currentDuration))")) {
            Text("")
        }
        .disabled(state != .playing)
        
        .padding()
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
    
    //#Preview {
    //    ReproductorView()
    //}
    
    
    var timeHMSFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute,.second]
        formatter.zeroFormattingBehavior = [.pad]
        return formatter
    }()
    
    
    func formatSecondsToHMS(_ seconds: Double) -> String {
        guard !seconds.isNaN, let text = timeHMSFormatter.string(from: seconds) else {
            return "00:00"
        }
        return text
    }
