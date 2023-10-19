//
//  SwiftUIView.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 11/10/23.
//

import SwiftUI
import SwiftData

struct EpisodeCellView: View {
    @ObservedObject var vm: DetailEpisodeViewModel
    
    var color: Color
    var body: some View {
        ZStack{
            VStack(alignment: .leading) {
                    Text(vm.episode.title)
                        .font(.headline)
                Text(vm.episode.date.formatted(date: .long, time: .omitted))
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                ButtonsStatusHStackView(vm: vm)
            }
            .background(color.padding(.horizontal,-40).padding(.vertical,-10))
        }
    }
}

#Preview {
    let container = ModelContainer.previewContainer
    let episode = Episodio.preview
    container.mainContext.insert(episode)
    
    
    return EpisodeCellView(vm: DetailEpisodeViewModel(episode: .preview),color: Color.clear1)
        .modelContainer(container)
}
