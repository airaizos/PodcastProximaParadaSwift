//
//  ModelContainer.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 18/10/23.
//

import Foundation
import SwiftData

extension ModelContainer {
    static var shared: ModelContainer = {
        let schema = Schema([
            Episodio.self,
            PostCategory.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
}
