//
//  AboutViewModel.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 16/10/23.
//

import SwiftUI


final class AboutViewModel:ObservableObject {
    let network: Network
    
    init(network: Network = Network()) {
        self.network = network
    }
    
    func aboutMe() async -> AttributedString {
       await network.fetchPageContent(page: .aboutMe)
        
    }
 
}
