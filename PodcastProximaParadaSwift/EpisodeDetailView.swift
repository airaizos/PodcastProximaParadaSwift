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
    @Bindable var episode: Episodio
    
    @ObservedObject var vm = DetailEpisodeViewModel()
    
  
    
    var body: some View {
        ScrollView {
            Text(episode.content)
                .font(.body)
        }
        .padding()
        List {
            Button {
                Task {
                 try await vm.play(episode: episode)
                }
            } label: {
                Image(systemName: "arrowtriangle.right.circle")
                    .font(.largeTitle)
            }
         
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

            Toggle("Escuchado", isOn: $episode.played)
            Toggle("Favorito", isOn: $episode.favorite)
                .disabled(!episode.played)
            TextEditor(text: $episode.comments)
                .frame(height: 200)
                .background(RoundedRectangle(cornerRadius: 10).stroke().foregroundStyle(Color.secondary).padding(-5))
        }
        .listStyle(.grouped)
        .navigationTitle("\(episode.title)")
        .navigationBarTitleDisplayMode(.inline)
    }
        
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Episodio.self, configurations: config)
        let example = Episodio(id: 99, title: "Episodio Z Zarandeando SwiftData", content: "Proyecto de prueba con SwiftData")
        
        
        return EpisodeDetailView(episode: example)
            .modelContainer(container)
    } catch {
        fatalError("No se ha podido crear el modelo")
    }
}
