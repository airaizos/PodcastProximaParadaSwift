//
//  Container.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 18/10/23.
//

import SwiftData

extension ModelContainer {
    
    static var previewContainer: ModelContainer {
        let schema = Schema([
            Episodio.self,
            PostCategory.self
        ])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: schema, configurations: config)
        
        return container
    }
}


