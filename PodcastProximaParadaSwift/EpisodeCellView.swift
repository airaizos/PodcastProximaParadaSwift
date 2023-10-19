//
//  SwiftUIView.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 11/10/23.
//

import SwiftUI
import SwiftData

struct EpisodeCellView: View {
    var episode: Episodio
    var color: Color
    var body: some View {
        ZStack{
            VStack(alignment: .leading) {
            HStack{
                Text("\(episode.id)")
                    .font(.subheadline)
                    .foregroundStyle(Color.secondary)
                Text(episode.title)
                    .font(.headline)
            }
            Text(episode.categoriesView)
                .font(.caption2)
                .foregroundStyle(.secondary)
            ButtonsStatusHStackView(played: episode.played, favorite: episode.favorite, downloaded: episode.audio.downloaded)
        }
            .background(color.padding(.horizontal,-40).padding(.vertical,-10))
    }
    }
}

#Preview {
    let container = ModelContainer.previewContainer
    let episode = Episodio.preview
        container.mainContext.insert(episode)
    

    return EpisodeCellView(episode: episode,color: Color.clear1)
        .modelContainer(container)
}
