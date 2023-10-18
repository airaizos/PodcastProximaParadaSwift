//
//  EpisodesListViewModel.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 4/10/23.
//

import Foundation
import AVFoundation
/**

 ViewModel de la vista del **listado** de episodios
 
Las funciones será descargar los datos de la API de wordpress del podcast [Proxima Parada Swift](www.proximaparadaswift.dev)
 
 Necesita de la clase `Network` que es la que se encarga de la llamada a la red.
 
 **¿Debería reproducir el epsiodio desde aqui?**
 
 */
final class EpisodesListViewModel: ObservableObject {
    let network: Network
    
    init(network: Network = Network()) {
        self.network = network
    }
    
    /// Descarga todos los episodios que hay en el endPoint [episodes](https://proximaparadaswift.dev/wp-json/wp/v2/posts?per_page=10) y devuelve `[Episodio]`
    func fetchEpisodes() async throws -> [Episodio] {
        var episodios: [Episodio] = []
        
        let apiEpisodios = try await network.fetchJson(url: network.urls.episodes, type: [APIEpisodio].self)
        
        for epi in apiEpisodios {
     
            episodios.append(Episodio(id: epi.id, title: epi.title.rendered, content: epi.content.rendered,categories: epi.categories))
            }
        
        return episodios
    }
}
