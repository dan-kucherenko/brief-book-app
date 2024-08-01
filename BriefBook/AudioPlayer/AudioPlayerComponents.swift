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
        HStack(spacing: 10) {
            backwardBtnView
            rewindBtnView
            playPauseBtnView
            forwardBtnView
            nextTrackBtnView
        }
    }
}

extension AudioPlayerControllers {
    private var backwardBtnView: some View {
        AudioPlayerButton(imageName: "backward.end.fill", size: .title2) {
            store.send(.previousTrackTapped)
        }
    }

    private var rewindBtnView: some View {
        AudioPlayerButton(imageName: "gobackward.5", size: .title) {
            store.send(.rewindTapped)
        }
    }

    private var playPauseBtnView: some View {
        AudioPlayerButton(imageName: store.isPlaying ? "pause.fill" : "play.fill",
                          size: .largeTitle) {
            store.send(.playPauseTapped)
        }
    }

    private var forwardBtnView: some View {
        AudioPlayerButton(imageName: "goforward.10", size: .title) {
            store.send(.forwardTapped)
        }
    }

    private var nextTrackBtnView: some View {
        AudioPlayerButton(imageName: "forward.end.fill", size: .title2) {
            store.send(.nextTrackTapped)
        }
    }
}

#Preview {
    AudioPlayerControllers(store: Store(initialState: AudioPlayerFeature.State()) {
        AudioPlayerFeature(audioPlayer: AudioPlayer.shared)
    })
}
