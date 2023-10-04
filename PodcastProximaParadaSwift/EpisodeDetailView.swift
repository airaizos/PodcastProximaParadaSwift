//
//  EpisodeDetailView.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 4/10/23.
//

import SwiftData
import SwiftUI

struct EpisodeDetailView: View {
    @Bindable var episode: Episodio
    
    var body: some View {
        ScrollView {
            Text(episode.content)
                .font(.body)
        }
        .padding()
        List {
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
