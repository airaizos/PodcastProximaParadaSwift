//
//  URLTesting.swift
//  PodcastProximaParadaSwiftTests
//
//  Created by Adrian Iraizos Mendoza on 20/10/23.
//

import Foundation

@testable import PodcastProximaParadaSwift
struct URLTesting: URLDestination {
    var enlaces: URL = .enlaces
    
    var categories: URL = URL(string:"https://proximaparadaswift.dev/wp-json/wp/v2/categories?per_page=1")!
    
    var aboutMe: URL = .aboutMe
    
    var episodes: URL = .lastEpisode

}
