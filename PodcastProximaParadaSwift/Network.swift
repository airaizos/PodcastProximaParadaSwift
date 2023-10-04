//
//  Network.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 4/10/23.
//

import Foundation


final class Network {
    
    var session: URLSession
    var urls: URLDestination
    
    init(session: URLSession = URLSession.shared, urls: URLDestination) {
        self.session = session
        self.urls = urls
    }
    
    func fetchJson<JSON:Codable>(url: URL, type: JSON.Type) async throws -> JSON {
       let (data,response) = try await  session.data(from: url)
        guard let res = response as? HTTPURLResponse else { throw NSError(domain: "No response", code: 0)}
        switch res.statusCode == 200 {
        case true:
            do {
                return try JSONDecoder().decode(JSON.self, from: data)
                
            } catch {
                throw NSError(domain: "JSON decoder error", code: 2)
            }
        case false: throw NSError(domain: "No data", code: 1)
            
        }
    }
}


protocol URLDestination {
    var episodes: URL { get }
    
}
