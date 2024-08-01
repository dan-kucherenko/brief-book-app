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
        HStack(spacing: 25) {
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
        Button {
            store.send(.previousTrackTapped)
        } label: {
            Image(systemName: "backward.end.fill")
                .font(.title)
        }
        .buttonStyle(PlainButtonStyle())
    }

    private var rewindBtnView: some View {
        Button {
            store.send(.rewindTapped)
        } label: {
            Image(systemName: "gobackward.5")
                .font(.title)
        }
        .buttonStyle(PlainButtonStyle())
    }

    private var playPauseBtnView: some View {
        Button {
            store.send(.playPauseTapped)
        } label: {
            Image(systemName: store.isPlaying ? "pause.fill" : "play.fill")
                .font(.largeTitle)
        }
        .buttonStyle(PlainButtonStyle())
    }

    private var forwardBtnView: some View {
        Button {
            store.send(.forwardTapped)
        } label: {
            Image(systemName: "goforward.10")
                .font(.title)
        }
        .buttonStyle(PlainButtonStyle())
    }

    private var nextTrackBtnView: some View {
        Button {
            store.send(.nextTrackTapped)
        } label: {
            Image(systemName: "forward.end.fill")
                .font(.title)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    AudioPlayerControllers(store: Store(initialState: AudioPlayerFeature.State()) {
        AudioPlayerFeature(audioPlayer: AudioPlayer.shared)
    })
}
