//
//  Network.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 4/10/23.
//

import Foundation


final class Network {
    
    let session: URLSession
    let urls: URLDestination
    let decoder: JSONDecoder
    
    init(session: URLSession = URLSession.shared, urls: URLDestination = URLProduction(), decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.urls = urls
        
        decoder.dateDecodingStrategy = .iso8601
        self.decoder = decoder
    }
    
    func fetchJson<JSON:Codable>(url: URL, type: JSON.Type) async throws -> JSON {
       let (data,response) = try await  session.data(from: url)
        guard let res = response as? HTTPURLResponse else { throw NSError(domain: "No response", code: 0)}
        switch res.statusCode == 200 {
        case true:
            do {
                
                return try decoder.decode(JSON.self, from: data)
                
            } catch {
                throw NSError(domain: "JSON decoder error", code: 2)
            }
        case false: throw NSError(domain: "No data", code: 1)
            
        }
    }
    
    func fetchURL(_ episode: Episodio) async throws -> URL? {
        let url = URL.episodeId(episode.id)
        
       let audioEpisodio = try await fetchJson(url: url, type: AudioEpisodio.self)
        
        return audioEpisodio.audioURL
    }
    
    /// Descarga todos los episodios que hay en el endPoint [episodes](https://proximaparadaswift.dev/wp-json/wp/v2/posts?per_page=10) y devuelve `[Episodio]`
    func fetchEpisodes() async throws -> [Episodio] {
        var episodios: [Episodio] = []
        
        let apiEpisodios = try await fetchJson(url: urls.episodes, type: [APIEpisodio].self)
        
        for epi in apiEpisodios {
            episodios.append(epi.episode)
            }
        
        return episodios
    }
    
}


protocol URLDestination {
    var episodes: URL { get }
    
}
