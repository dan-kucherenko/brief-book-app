//
//  AudioPlayerView.swift
//  BriefBook
//
//  Created by Daniil on 18.07.2024.
//

import SwiftUI
import ComposableArchitecture

struct AudioPlayerView: View {
    @Bindable var store: StoreOf<AudioPlayerFeature>

    var body: some View {
        VStack {
            timeSliderView
            speedButton
            AudioPlayerControllers(store: store)
                .padding(.top, 30)
        }
        .onReceive(Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()) { _ in
            store.send(.updateTimeStampProgress)
        }
    }
}

// MARK: - Decomposed body views
extension AudioPlayerView {
    private var timeSliderView: some View {
        HStack {
            Text("\(formatTime(store.currentTime))")
                .frame(minWidth: 50, alignment: .leading)

            Slider(value: $store.currentTime.sending(\.timeStampChanged), in: 0...store.totalTime)
            .layoutPriority(1)
            .tint(.blue)

            Text("\(formatTime(store.totalTime))")
                .frame(minWidth: 50, alignment: .trailing)
        }
    }

    private var speedButton: some View {
        Button {
            store.send(.speedChanged)
        } label: {
            Text("Speed x\(store.speed.formatted)")
                .bold()
                .foregroundStyle(.speedLabel)
                .font(.system(size: 14))
                .padding(7)
        }
        .frame(width: 90)
        .background(.gray.opacity(0.2))
        .cornerRadius(8)
    }
}

extension AudioPlayerView {
    private func formatTime(_ time: TimeInterval) -> String {
        let seconds = Int(time) % 60
        let minutes = Int(time) / 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    AudioPlayerView(store: Store(initialState: AudioPlayerFeature.State()) {
        AudioPlayerFeature()
    })
}
