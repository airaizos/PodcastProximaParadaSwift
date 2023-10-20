//
//  Network.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 4/10/23.
//

import SwiftUI

/**
 Clase encargada de conectarse a la *API* para la descarga de archivos *json*
 */
final class Network {
    
    let session: URLSession
    let urls: URLDestination
    let decoder: JSONDecoder
    
    init(session: URLSession = URLSession.shared, urls: URLDestination = URLProduction(), decoder: JSONDecoder = JSONDecoder()) {
       let df = DateFormatter()
       df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        self.session = session
        self.urls = urls
    
        decoder.dateDecodingStrategy = .formatted(df)
        self.decoder = decoder
    }
    
    /// Devueelve un json a partir de un `struct` conformado con `Codable`
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
    
    /// Busca la ruta URL del audio apartir del contenido del post, con un patrón definido en Regex en `AudioEpisodio`
    func fetchURL(_ episode: Episodio) async throws -> URL? {
        let url = URL.episodeId(episode.id)
        
       let audioEpisodio = try await fetchJson(url: url, type: AudioEpisodio.self)
        
        return audioEpisodio.audioURL
    }
    
    /// Descarga todos los episodios que hay en el endPoint [episodes](https://proximaparadaswift.dev/wp-json/wp/v2/posts?per_page=100) y devuelve `[Episodio]`
    func fetchEpisodes() async -> [Episodio] {
        do {
            let apiEpisodios = try await fetchJson(url: urls.episodes, type: [APIEpisodio].self)
            
            return apiEpisodios.map { $0.episodio }
        } catch {
            return []
        }
    }
    
    /// Descarga las categorias de los posts
    func fetchCategories() async -> [PostCategory] {
        do {
            let apiCategories = try await fetchJson(url: urls.categories, type: [APIPostCategory].self)
            
            return apiCategories.map { $0.postCategory }
        } catch {
            return []
        }
    }
    
    /// Descarga el contenido de una pagina a partir de su id y devuelve un AttributedString
    func fetchPageContent(page: PagesContent) async -> AttributedString {
        do {
            
            let page = try await fetchJson(url: page.enlace, type: APIPage.self)
            
            if let content = attributedTextFromHTML(page.content.rendered) {
                var result = content
                result.font = Font.body
                result.foregroundColor = Color.darkest
                return result
            } else {
                return "**No Content**"
            }
        } catch {
            return "**No Content**"
        }
        
    }
    
    enum PagesContent {
        case aboutMe, enlaces
        
        var enlace:URL {
            switch self {
            case .aboutMe: .aboutMe
            case .enlaces: .enlaces
            }
            
        }
    }
}



