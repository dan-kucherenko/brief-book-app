//
//  AudioPlayerControllers.swift
//  BriefBook
//
//  Created by Daniil on 19.07.2024.
//

import SwiftUI
import ComposableArchitecture

struct AudioPlayerControllers: View {
    let store: StoreOf<AudioPlayerControllersFeature>

    private let playIcon = "play.fill"
    private let pauseIcon = "pause.fill"
    private let backwardIcon = "backward.end.fill"
    private let goBackwardIcon = "gobackward.5"
    private let goForwardIcon = "goforward.10"
    private let forwardIcon = "forward.end.fill"
    
    var body: some View {
        HStack(spacing: 20) {
            Button {
                store.send(.previousTrackTapped)
            } label: {
                Image(systemName: backwardIcon)
                    .font(.title)
            }
            .buttonStyle(PlainButtonStyle())
            
            Button {
                store.send(.rewindTapped)
            } label: {
                Image(systemName: goBackwardIcon)
                    .font(.title)
            }
            .buttonStyle(PlainButtonStyle())
            
            Button {
                store.send(.playPauseTapped)
            } label: {
                Image(systemName: store.isPlaying ? pauseIcon : playIcon)
                    .font(.largeTitle)
            }
            .buttonStyle(PlainButtonStyle())
            
            Button {
                store.send(.forwardTapped)
            } label: {
                Image(systemName: goForwardIcon)
                    .font(.title)
            }
            .buttonStyle(PlainButtonStyle())
            
            Button {
                store.send(.nextTrackTapped)
            } label: {
                Image(systemName: forwardIcon)
                    .font(.title)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

#Preview {
    AudioPlayerControllers(
        store: Store(initialState: AudioPlayerControllersFeature.State()) {
            AudioPlayerControllersFeature()
        }
    )
}
