//
//  Categories.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 11/10/23.
//

import Foundation
import SwiftData

@Model
final class PostCategory {
    let id: Int
    let name: String
    let count:Int
    
    init(id: Int = 0, name: String = "", count: Int = 0) {
        self.id = id
        self.name = name
        self.count = count
    }
}
