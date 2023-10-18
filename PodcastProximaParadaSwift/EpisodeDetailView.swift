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
    @ObservedObject var vm: DetailEpisodeViewModel
    
    @State var time = 0.0
    
    @State var audioFileState = AudioFileState.none
    
   // let player = AVPlayer()
    let player = AVPlayer()
    var body: some View {
        ZStack{
            Color.darkest
                .ignoresSafeArea()
                .zIndex(-1)
            VStack {
                Text(vm.episode.title)
                    .font(.largeTitle)
                    .foregroundStyle(Color.pinkest)
                ScrollView {
                    Text(vm.episode.content)
                      
                        .font(.body)
                        .foregroundStyle(Color.clear1)
                    
                }
                
                
                .padding()
                
                
                //TODO: Ajustar bien la velocidad y el pitch
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
                                  
                                
                                    //-
                                    vm.changeRate(up: false)
                                    player.rate = vm.rate
                              
                                } label: {
                                    Image(systemName: "minus")
                                    
                                }
                                .disabled(vm.rate == 1)
                                .buttonStyle(StepperPPSStyle())
                                Button("+") {
                                   
                                    //+
                                    vm.changeRate(up: true)
                                    player.rate = vm.rate
                                
                                }
                                .disabled(vm.stepRate == 6)
                            }
                            .buttonStyle(StepperPPSStyle())
                        }
                    
                    
                    HStack {
                        Toggle("Escuchado", isOn: $vm.episode.played)
                            .toggleStyle(TogglePPSStyle())
                        Toggle("Favorito", isOn: $vm.episode.favorite)
                            .disabled(!vm.episode.played)
                            .toggleStyle(TogglePPSStyle())
                    }
                    
                    .padding(.vertical, 10)
                }
                .padding(.horizontal)
                .background(Color.darkest)
                .foregroundStyle(Color.clear1)
                
                TextEditor(text: $vm.episode.comments)
                    .frame(height: 200)
                    .background(RoundedRectangle(cornerRadius: 10).stroke().foregroundStyle(Color.darkest).padding(-5))
                
                    .foregroundStyle(Color.darker)
                
                
                    .padding(.horizontal)
            }
        }

        .navigationTitle("\(vm.episode.title)")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            
            audioFileState = vm.isAudioEpisodeDownloaded() ? .downloaded : .none
        }
        .onDisappear {
            self.player.replaceCurrentItem(with: nil)
        }
        
    }
    
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Episodio.self, configurations: config)
        let example = Episodio(id: 99, title: "Episodio Z Zarandeando SwiftData", content: "Proyecto de prueba con SwiftData \n Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod justo in ligula lacinia, in elementum libero iaculis. Duis rhoncus, felis nec aliquam consectetur, felis elit tincidunt libero, sit amet hendrerit felis lectus eget libero. Nulla facilisi. Praesent aliquam, augue eget porttitor blandit, mauris nisi tincidunt erat, ac ultricies orci elit nec quam. Fusce in lacinia ante, et rhoncus dui. Curabitur eget risus dui. Nulla ut libero id libero euismod auctor vel eget libero. Nulla nec tortor quis arcu sodales bibendum ut ac urna. Etiam et arcu auctor, efficitur ex ut, varius turpis. Proin quis odio eu sapien efficitur tincidunt non non justo. Aenean id tellus vel odio pellentesque efficitur at nec purus. ")
        
        
        return EpisodeDetailView(vm: DetailEpisodeViewModel(episode: example))
            .modelContainer(container)
    } catch {
        fatalError("No se ha podido crear el modelo")
    }
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
