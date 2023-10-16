//
//  EnlacesViewModel.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 16/10/23.
//

import Foundation


final class EnlacesViewModel: ObservableObject {
    let network: Network
    
    init(network: Network = Network()) {
        self.network = network
    }
    
    func fetchEnlaces() async -> AttributedString {
        do {
            let page = try await network.fetchJson(url: .enlaces, type: APIPage.self)
            
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
