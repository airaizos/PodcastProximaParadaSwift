//
//  EpisodeDetailView.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 4/10/23.
//

import SwiftData
import SwiftUI
import AVKit

struct EpisodeDetailView: View {
    @ObservedObject var vm: DetailEpisodeViewModel
    
    @State var time = 0.0
    
    
    var body: some View {
        ZStack{
            
            ScrollView {
                Text(vm.episode.title)
                    .font(.largeTitle)
                    .foregroundStyle(Color.pinkest)
                Text(vm.episode.content)
                    .font(.body)
                    .foregroundStyle(Color.clear1)
                
            }
            .padding()
        
        Color.darkest
            .ignoresSafeArea()
            .zIndex(-1)
        }
            HStack{
                Group {
                    if vm.isPlaying {
                       
                        Button {
                            vm.isPlaying.toggle()
                            vm.pause(episode: vm.episode)
                        } label: {
                            Image(systemName: "pause.circle")
                                .font(.largeTitle)
                        }
                    } else {
                        Button {
                            vm.isPlaying.toggle()
                            Task {
                                try vm.play(episode: vm.episode)
                            }
                        } label: {
                            Image(systemName: "arrowtriangle.right.circle")
                                .font(.largeTitle)
                        }
                    }
                    
                }
                
                Button{
                    vm.goSeconds(-15)
                } label: {
                    Image(systemName: "gobackward.15")
                }
                .disabled(!vm.isPlaying)
                .frame(width: 44)
                ProgressView(timerInterval: vm.duration, countsDown: true) {
                    Text("label")
                } currentValueLabel: {
                    Text("current")
                }
                Button{
                    vm.goSeconds(15)
                } label: {
                    Image(systemName: "goforward.15")
                }
                .disabled(!vm.isPlaying)
                .frame(width: 44)
                

       
        }
        List {
            //TODO: Ajustar bien la velocidad y el pitch
                VStack{
                    Stepper(value: $vm.speed, in: -0.5...1.5, step: 0.1) {
                        HStack {
                            Text("Speed")
                            Spacer()
                            Text(" \(vm.speed,format: .number.precision(.integerLength(0)))")
                                .padding(.trailing,20)
                                .foregroundStyle(vm.speed != 1 ? .red : .green)
                        }
                    }
                    Stepper(value: $vm.pitch, in: -0.5...10, step: 0.5) {
                        HStack {
                            Text("Pitch")
                            Spacer()
                            Text(" \(vm.pitch,format: .number.precision(.integerLength(1)))")
                                .padding(.trailing,20)
                                .foregroundStyle(vm.pitch != 0 ? .red : .green)
                        }
                    }
                }
            Toggle("Escuchado", isOn: $vm.episode.played)
            Toggle("Favorito", isOn: $vm.episode.favorite)
                .disabled(!vm.episode.played)
            TextEditor(text: $vm.episode.comments)
                .frame(height: 200)
                .background(RoundedRectangle(cornerRadius: 10).stroke().foregroundStyle(Color.secondary).padding(-5))
        }
        .scrollContentBackground(.hidden)
        .background(Color.darkest)
        .listStyle(.grouped)
        .navigationTitle("\(vm.episode.title)")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            Task {
                vm.duration = await vm.getEpisodeTimeInterval()
            }
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

