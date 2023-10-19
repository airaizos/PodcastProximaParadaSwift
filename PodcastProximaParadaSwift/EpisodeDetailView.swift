//
//  EpisodeDetailView.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 4/10/23.
//

import SwiftData
import SwiftUI
import AVFoundation

struct EpisodeDetailView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: DetailEpisodeViewModel
    
    @State var audioFileState = AudioFileState.none
    
    let player = AVPlayer()
    var body: some View {
        ZStack(alignment:.leading) {
           
            Color.darkest
                .ignoresSafeArea()
                .zIndex(-1)
            VStack {
                HStack {
                    Button{
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title)
                        
                    }
                    .frame(height: 44)
                    .padding(.horizontal)
                    Spacer()
                }
                Text(vm.episode.title)
                    .font(.largeTitle)
                    .foregroundStyle(Color.pinkest)
                    .padding(.horizontal,10)
                   
                ScrollView {
                    Text(vm.episode.attributedContent(dark: false))
                }
                .padding()
                
                HStack {
                    ButtonPlayerView(state: $audioFileState) {
                        switch audioFileState {
                        case .none:
                            Task {
                                try await vm.saveAudioData()
                                audioFileState = .downloaded
                            }
                        case .downloaded:
                            let playerItem = AVPlayerItem(url: vm.audioURL)
                            self.player.replaceCurrentItem(with: playerItem)
                            self.player.play()
                            
                            audioFileState = vm.isAudioEpisodeDownloaded() ? .playing : .downloaded
                            
                        case .playing:
                            self.player.pause()
                            
                            audioFileState = .pause
                        case .pause:
                            
                            self.player.play()
                            audioFileState = .playing
                        }
                    }
                    ReproductorControlsView(player: player,
                                            timeObserver: PlayerTimeObserver(player: player),
                                            durationObserver: PlayerDurationObserver(player: player),
                                            itemObserver: PlayerItemObserver(player: player))
                }
                .padding(.horizontal)
                .background(Color.darkest)
                VStack {
                    HStack {
                        Text("Speed")
                        Spacer()
                        Text(" \(vm.rate,format: .number.precision(.integerLength(1)))x")
                            .padding(.trailing,20)
                            .foregroundStyle(vm.rate != 1 ? Color.pinkest : Color.clear1)
                        HStack(spacing: -13) {
                            
                            Button {
                                vm.changeRate(up: false)
                                player.rate = vm.rate
                                
                            } label: {
                                Image(systemName: "minus")
                            }
                            .disabled(vm.rate == 1)
                            .buttonStyle(StepperPPSStyle())
                            Button("+") {
                                vm.changeRate(up: true)
                                player.rate = vm.rate
                                
                            }
                            .disabled(vm.stepRate == 6)
                        }
                        .buttonStyle(StepperPPSStyle())
                    }
                    
                    
                    HStack {
                        Toggle("Escuchado", isOn: $vm.episode.played)
                        Toggle("Favorito", isOn: $vm.episode.favorite)
                            .disabled(!vm.episode.played)
                         
                    }
                    .tint(Color.pink1)
                    .padding(.vertical, 10)
                }
                .padding(.horizontal)
                .background(Color.darkest)
                .foregroundStyle(Color.clear1)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .tint(Color.white)
        .onAppear {
            
            audioFileState = vm.isAudioEpisodeDownloaded() ? .downloaded : .none
        }
        .onDisappear {
            self.player.replaceCurrentItem(with: nil)
        }
    }
}

#Preview {
    let container = ModelContainer.previewContainer
    let example = Episodio.preview
    
    return EpisodeDetailView(vm: DetailEpisodeViewModel(episode: example))
        .modelContainer(container)
    
}

enum AudioFileState {
    case none, downloaded, playing, pause
    
}

struct ButtonPlayerView: View {
    @Binding var state: AudioFileState
    var action: () -> Void
    
    var body: some View {
        Group {
            switch state {
            case .none: Button {
                action()
            } label: {
                Image(systemName: "arrow.down.circle")
                    .font(.title)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color.clearest,Color.pinkest)
            }
            .frame(width: 44)
                
                
            case .downloaded: Button {
                action()
            } label: {
                Image(systemName: "play.circle")
                    .font(.title)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color.clearest,Color.pinkest)
                    .frame(width: 44)
            }
                
            case .playing: Button {
                action()
            } label: {
                Image(systemName: "pause.circle")
                    .font(.title)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color.clearest,Color.pinkest)
                    .frame(width: 44)
            }
                
            case .pause: Button {
                action()
            } label: {
                Image(systemName: "play.circle")
                    .font(.title)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color.clearest,Color.pinkest)
                    .frame(width: 44)
            }
            }
        }
    }
}
