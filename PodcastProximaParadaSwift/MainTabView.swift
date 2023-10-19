//
//  MainTabView.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 19/10/23.
//

import SwiftUI
import SwiftData

struct MainTabView: View {
    @ObservedObject var vm: EpisodesListViewModel
    @Binding var navigationState: NavigationState
   
    var body: some View {
        TabView {
            EpisodesListView(vm:vm)
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
        .modelContainer(.shared)
        .tint(Color.darkest)
    }
}

#Preview {
    MainTabView(vm: EpisodesListViewModel(),navigationState: .constant(.episodes))
}
