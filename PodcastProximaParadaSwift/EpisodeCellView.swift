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
    var body: some View {
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
            
            
            Text(episode.content)
                .lineLimit(2)
                .font(.caption2)
            Text("\(episode.audio.duration.formatted(.time(pattern: .minuteSecond)))")
        }
      
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Episodio.self, configurations: config)
        let episode = Episodio(id: 99, title: "Episodio No: \(99)", content: "Contenido del episodio \(99) \n Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod justo in ligula lacinia, in elementum libero iaculis. Duis rhoncus, felis nec aliquam consectetur, felis elit tincidunt libero, sit amet hendrerit felis lectus eget libero. Nulla facilisi. Praesent aliquam, augue eget porttitor blandit, mauris nisi tincidunt erat, ac ultricies orci elit nec quam. Fusce in lacinia ante, et rhoncus dui. Curabitur eget risus dui. Nulla ut libero id libero euismod auctor vel eget libero. Nulla nec tortor quis arcu sodales bibendum ut ac urna. Etiam et arcu auctor, efficitur ex ut, varius turpis. Proin quis odio eu sapien efficitur tincidunt non non justo. Aenean id tellus vel odio pellentesque efficitur at nec purus. ", categories: [2,3,4])
        container.mainContext.insert(episode)
    

   return EpisodeCellView(episode: episode)
        .modelContainer(container)
}
