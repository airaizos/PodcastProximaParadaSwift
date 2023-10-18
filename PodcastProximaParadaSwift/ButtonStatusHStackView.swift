//
//  ButtonStatusHStackView.swift
//  PodcastProximaParadaSwift
//
//  Created by Adrian Iraizos Mendoza on 8/10/23.
//

import SwiftUI

struct ButtonsStatusHStackView: View {
    var played: Bool
    var favorite: Bool
    var downloaded: Bool
    var action: () -> ()
    var body: some View {
        HStack{
            Button {
               action()
                print("shared")
            } label: {
                Image(systemName: "square.and.arrow.up")
                    .foregroundStyle(Color.darkest)
            }
            .frame(width: 44, height: 44)
            
            Button {
                action()
                print("played")
            } label: {
                Image(systemName: played  ? "checkmark" : "xmark")
                
                    .foregroundStyle(played ? Color.orange : Color.yellow)
            }
            .frame(width: 44, height: 44)
            
            Button {
                action()
                print("favorite")
            } label: {
                
                Image(systemName: favorite ? "heart" : "heart.slash")
                    .foregroundStyle(favorite ? Color.red : Color.gray)
            }
            .frame(width: 44, height: 44)
            
            Spacer()
            Button {
                action()
                print("descarga")
            } label: {
                Image(systemName: "arrow.down.circle")
                    .foregroundStyle(Color.darkest)
            }
            .frame(width: 44, height: 44)
        }
        .buttonStyle(.borderless)
    }
}

#Preview {
    ButtonsStatusHStackView(played: true, favorite: false, downloaded: true) { }
}
