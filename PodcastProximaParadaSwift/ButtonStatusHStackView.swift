//
//  ButtonStatusHStackView.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 8/10/23.
//

import SwiftUI

struct ButtonsStatusHStackView: View {
    @ObservedObject var vm: DetailEpisodeViewModel
  
    var body: some View {
        HStack{
            ShareLink("", item: vm.episode.link)
            .frame(width: 44, height: 44)
            .tint(Color.brown)
            Button {
                vm.episode.played.toggle()
            } label: {
                Image(systemName: vm.episode.played  ? "checkmark" : "xmark")
                
                    .foregroundStyle(vm.episode.played ? Color.orange : Color.yellow)
            }
            .frame(width: 44, height: 44)
            
            Button {
                vm.episode.favorite.toggle()
            } label: {
                
                Image(systemName: vm.episode.favorite ? "heart" : "heart.slash")
                    .foregroundStyle(vm.episode.favorite ? Color.red : Color.gray)
            }
            .frame(width: 44, height: 44)
            
            Spacer()
            Button {
                Task {
                   try await vm.saveAudioData()
                }
            } label: {
                Image(systemName: vm.isAudioEpisodeDownloaded() ? "checkmark" :"arrow.down.circle")
                    .foregroundStyle(Color.darkest)
            }
            .frame(width: 44, height: 44)
        }
        .buttonStyle(.borderless)
    }
}

#Preview {
    ButtonsStatusHStackView(vm: DetailEpisodeViewModel(episode: .preview))
}
