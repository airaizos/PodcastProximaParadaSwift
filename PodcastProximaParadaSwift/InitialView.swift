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
    @StateObject var vm = EpisodesListViewModel()


    var body: some View {
        Group {
            switch navigationState {
            case .splash: SplashView(vm: vm, navigationState: $navigationState)
                    .modelContainer(.shared)
            case .episodes: MainTabView(vm: vm,navigationState: $navigationState)
            }
             
        }
       
    }
}

#Preview {
    InitialView(navigationState: .constant(.splash))
}

