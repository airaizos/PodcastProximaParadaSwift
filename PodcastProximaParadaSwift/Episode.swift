//
//  Episode.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 4/10/23.
//

import Foundation
import SwiftData

@Model
final class Episodio {
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
}

extension Episodio {
    static var preview =  Episodio(id: 99, title: "Episodio No: \(99)", content: "Contenido del episodio \(99) \n Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod justo in ligula lacinia, in elementum libero iaculis. Duis rhoncus, felis nec aliquam consectetur, felis elit tincidunt libero, sit amet hendrerit felis lectus eget libero. Nulla facilisi. Praesent aliquam, augue eget porttitor blandit, mauris nisi tincidunt erat, ac ultricies orci elit nec quam. Fusce in lacinia ante, et rhoncus dui. Curabitur eget risus dui. Nulla ut libero id libero euismod auctor vel eget libero. Nulla nec tortor quis arcu sodales bibendum ut ac urna. Etiam et arcu auctor, efficitur ex ut, varius turpis. Proin quis odio eu sapien efficitur tincidunt non non justo. Aenean id tellus vel odio pellentesque efficitur at nec purus. ", categories: [3,4,99])
}
