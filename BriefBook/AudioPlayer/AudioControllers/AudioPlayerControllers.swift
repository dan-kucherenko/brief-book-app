//
//  AudioPlayerControllers.swift
//  BriefBook
//
//  Created by Daniil on 19.07.2024.
//

import SwiftUI
import ComposableArchitecture

struct AudioPlayerControllers: View {
    let store: StoreOf<AudioPlayerFeature>

    var body: some View {
        HStack(spacing: 20) {
            Button {
                store.send(.previousTrackTapped)
            } label: {
                Image(systemName: "backward.end.fill")
                    .font(.title)
            }
            .buttonStyle(PlainButtonStyle())

            Button {
                store.send(.rewindTapped)
            } label: {
                Image(systemName: "gobackward.5")
                    .font(.title)
            }
            .buttonStyle(PlainButtonStyle())

            Button {
                store.send(.playPauseTapped)
            } label: {
                Image(systemName: store.isPlaying ? "pause.fill" : "play.fill")
                    .font(.largeTitle)
            }
            .buttonStyle(PlainButtonStyle())

            Button {
                store.send(.forwardTapped)
            } label: {
                Image(systemName: "goforward.10")
                    .font(.title)
            }
            .buttonStyle(PlainButtonStyle())

            Button {
                store.send(.nextTrackTapped)
            } label: {
                Image(systemName: "forward.end.fill")
                    .font(.title)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

#Preview {
    AudioPlayerControllers(store: Store(initialState: AudioPlayerFeature.State()) {
        AudioPlayerFeature()
    })
}
