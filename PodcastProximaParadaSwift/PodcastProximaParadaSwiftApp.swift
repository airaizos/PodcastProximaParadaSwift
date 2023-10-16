//
//  PodcastProximaParadaSwiftApp.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 4/10/23.
//

import SwiftUI
import SwiftData

@main
struct PodcastProximaParadaSwiftApp: App {
    var sharedModelContainer: ModelContainer = {
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

    var body: some Scene {
        WindowGroup {
            TabView {
                EpisodesListView()
                    .tabItem {
                        Image(systemName: "music.note.list")
                    }
                  
                CategoriesView()
                    .tabItem {
                        Image(systemName: "checklist.unchecked")
                    }
                EnlacesView()
                    .tabItem {
                        Image(systemName: "link")
                    }
                AboutView()
                    .tabItem {
                        Image(systemName: "info")
                    }
            }
            .modelContainer(sharedModelContainer)
        
        
        }
        
    }
}
