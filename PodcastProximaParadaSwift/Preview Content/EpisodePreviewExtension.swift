//
//  EpisodePreviewExtension.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 19/10/23.
//

import Foundation

extension Episodio {
    static var preview =  Episodio(id: 99, title: "Episodio No: \(99)", content: "Contenido del episodio \(99) \n Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod justo in ligula lacinia, in elementum libero iaculis. Duis rhoncus, felis nec aliquam consectetur, felis elit tincidunt libero, sit amet hendrerit felis lectus eget libero. Nulla facilisi. Praesent aliquam, augue eget porttitor blandit, mauris nisi tincidunt erat, ac ultricies orci elit nec quam. Fusce in lacinia ante, et rhoncus dui. Curabitur eget risus dui. Nulla ut libero id libero euismod auctor vel eget libero. Nulla nec tortor quis arcu sodales bibendum ut ac urna. Etiam et arcu auctor, efficitur ex ut, varius turpis. Proin quis odio eu sapien efficitur tincidunt non non justo. Aenean id tellus vel odio pellentesque efficitur at nec purus. ", categories: [3,4,99])
    

    
    static var previewTenEpisodes: [Episodio] {
        var episodes = [Episodio]()
        for i in 1..<10 {
            var episode = Episodio(id: i, title: "Episodio No: \(i)", content: "Contenido del episodio \(i) \n Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod justo in ligula lacinia, in elementum libero iaculis. Duis rhoncus, felis nec aliquam consectetur, felis elit tincidunt libero, sit amet hendrerit felis lectus eget libero. Nulla facilisi. Praesent aliquam, augue eget porttitor blandit, mauris nisi tincidunt erat, ac ultricies orci elit nec quam. Fusce in lacinia ante, et rhoncus dui. Curabitur eget risus dui. Nulla ut libero id libero euismod auctor vel eget libero. Nulla nec tortor quis arcu sodales bibendum ut ac urna. Etiam et arcu auctor, efficitur ex ut, varius turpis. Proin quis odio eu sapien efficitur tincidunt non non justo. Aenean id tellus vel odio pellentesque efficitur at nec purus. ", categories: [2,3,4])
            episode.played = i % 3 == 0
            episode.favorite = i % 2 == 0
            
            episodes.append(episode)
        }
        return episodes
    }
}
