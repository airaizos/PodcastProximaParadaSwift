//
//  URLProduction.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 4/10/23.
//

import Foundation


struct URLProduction: URLDestination {
    var episodes: URL = .episodes
    var categories: URL = .categories
    
    var aboutMe: URL = .aboutMe
    var enlaces: URL = .enlaces
    


}

protocol URLDestination {
    var episodes: URL { get }
    var categories: URL { get }
    
    var aboutMe: URL { get }
    var enlaces: URL  { get }
}
