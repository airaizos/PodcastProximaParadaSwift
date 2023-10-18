//
//  Episode.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 4/10/23.
//

/*
 Nota sobre Unique Values: cloudKit no los soporta, actualizará los valores al último
 
 */

import SwiftUI
import SwiftData

@Model
final class Episodio {
   // @Attribute(.unique) let id: Int
    let id: Int
    let title: String
    let content: String
    let categories: [Int]
    var played: Bool = false
    var favorite: Bool = false
    var comments: String = ""
    var audio: AudioFile = AudioFile(downloaded: false, pathAudio: "", timeInterval: 1445)
    
    init(id: Int = 0, title: String = "", content: String = "", categories: [Int] = []) {
        self.id = id
        self.title = title
        self.content = content
        self.categories = categories
    }
}

extension Episodio {
    
    var categoriesView: String {
        ListFormatter.localizedString(byJoining: categories.map { "\($0)" } )
    }
    
    func attributedContent(dark: Bool) -> AttributedString {
        if let att = attributedTextFromHTML(content) {
            var result = att
            result.foregroundColor = dark ? Color.darkest : Color.clear1
            result.font = .body
            return result
        }
       return ""
    }
    
}

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
