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
    let id: Int
    let title: String
    let content: String
    let categories: [Int]
    let categoriesString: String
    let link: URL
    let date: Date
    var played: Bool = false
    var favorite: Bool = false
    var comments: String = ""
    var audio: AudioFile = AudioFile(downloaded: false, pathAudio: "", timeInterval: 1445)
    
    init(id: Int = 0, title: String = "", content: String = "", categories: [Int] = [], categoriesString: String = "", link: URL = .previewLink, date: Date = Date()) {
        self.id = id
        self.title = title
        self.content = content
        self.categories = categories
        self.categoriesString = categoriesString
        self.link = link
        self.date = date
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
