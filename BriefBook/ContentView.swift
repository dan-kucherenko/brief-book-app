//
//  ContentView.swift
//  BriefBook
//
//  Created by Daniil on 16.07.2024.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    let audioControllersStore: StoreOf<AudioPlayerFeature>
    let tabStore: StoreOf<TabsFeature>
    
    var body: some View {
        VStack {
            VStack {
                Image("BookPhotoPlaceholder")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 240)
                Text("KEY POINT 2 OF 10")
                    .font(.subheadline)
                    .bold()
                    .padding(.top, 30)
                    .foregroundStyle(.gray)
                Text("Design is not how a thing looks, but how it works")
                    .font(.callout)
                    .multilineTextAlignment(.center)
                    .padding(.top, 5)
                    .padding(.horizontal, 25)
            }
            
            AudioPlayerView(store: audioControllersStore, url: Bundle.main.url(forResource: "test_audio", withExtension: "mp3"))
                .padding()
            
            TabsView(store: tabStore)
                .padding(.top, 40)
        }
        //        .padding()
    }
}

#Preview {
    ContentView(
        audioControllersStore: Store(initialState: AudioPlayerFeature.State()) { AudioPlayerFeature()},
        tabStore: Store(initialState: TabsFeature.State()) {
            TabsFeature()
        }
    )
}
