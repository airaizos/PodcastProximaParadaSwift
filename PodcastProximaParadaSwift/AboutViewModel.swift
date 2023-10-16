//
//  AboutViewModel.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 16/10/23.
//

import Foundation


final class AboutViewModel:ObservableObject {
    let network: Network
    
    init(network: Network = Network()) {
        self.network = network
    }
    
    func fetchPageAboutMe() async -> AttributedString {
        do {
            let page = try await network.fetchJson(url: .aboutMe, type: APIPage.self)
            
            
            if let content = attributedTextFromHTML(page.content.rendered) {
                return content
            } else {
                return "**No Content**"
            }
        } catch {
            return "**No Content**"
        }
        
    }
    

    
}
