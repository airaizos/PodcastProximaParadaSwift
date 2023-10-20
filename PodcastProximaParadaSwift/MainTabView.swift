//
//  MainTabView.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 19/10/23.
//

import SwiftUI
import SwiftData

struct MainTabView: View {
    @Binding var navigationState: NavigationState
   
    var body: some View {
        TabView {
            EpisodesListView()
                .tabItem {
                    Image(systemName: "music.note.list")
                }
                .environment(EpisodesListViewModel())
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
        .modelContainer(.shared)
        .tint(Color.darkest)
    }
}

#Preview {
    MainTabView(navigationState: .constant(.episodes))
        .environment(EpisodesListViewModel())
}
