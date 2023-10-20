//
//  InitialView.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 19/10/23.
//

import SwiftUI
import SwiftData

struct InitialView: View {
  
    @Namespace var namespace
    @Binding var navigationState: NavigationState
    var body: some View {
        Group {
            switch navigationState {
            case .splash: SplashView(navigationState: $navigationState)
                    .environment(EpisodesListViewModel())
                    .modelContainer(.shared)
            case .episodes: MainTabView(navigationState: $navigationState)
                    .environment(EpisodesListViewModel())
            }
               
        }
       
    }
}

#Preview {
    InitialView(navigationState: .constant(.splash))
}

