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
    
    
    var body: some View {
        HStack{
            Button {
                print("Compartir")
            } label: {
                
                Image(systemName: "square.and.arrow.up")

            }
            Button {
                print("Escuchado")
            } label: {
                Image(systemName: played  ? "checkmark" : "xmark")
                
                    .foregroundStyle(played ? Color.orange : Color.yellow)
            }
            Button {
                print("Favorito")
            } label: {
                
                Image(systemName: favorite ? "heart" : "heart.slash")
                    .foregroundStyle(favorite ? Color.red : Color.gray)
                
            }
            Spacer()
            Button {
                print("Descargado")
            } label: {
                Image(systemName: "arrow.down.circle")
            }
        }
        .buttonStyle(.bordered)
    }
}

#Preview {
    ButtonsStatusHStackView(played: true, favorite: false, downloaded: true)
}
