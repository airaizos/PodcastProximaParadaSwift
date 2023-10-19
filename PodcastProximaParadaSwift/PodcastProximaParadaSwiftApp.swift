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
    @State var navigationState: NavigationState = .splash
    
    var body: some Scene {
        WindowGroup {
            InitialView(navigationState: $navigationState)
        }
    }
}

enum NavigationState {
    case splash, episodes
}
