//
//  APIPostCategory.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 11/10/23.
//

import Foundation

struct APIPostCategory: Codable {
    let id: Int
    let name: String
    let count:Int
    
    var postCategory: PostCategory {
        PostCategory(id: id, name: name, count: count)
    }
}
