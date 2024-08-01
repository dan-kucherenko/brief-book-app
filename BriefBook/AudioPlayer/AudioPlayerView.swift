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
    var url: URL?

    var body: some View {
        VStack {
            HStack {
                Text("\(formatTime(store.currentTime))")

                Slider(value: Binding(get: {
                    store.currentTime
                }, set: { newValue in
                    store.send(.timeStampChanged(newValue))
                }), in: 0...store.totalTime)
                .tint(.blue)

                Spacer()

                Text("\(formatTime(store.totalTime))")
            }
            .padding(.horizontal)

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
            .background(.gray).opacity(0.2)
            .cornerRadius(8)

            AudioPlayerControllers(store: store)
                .padding(.top, 30)
        }
        .onAppear {
            if let url = url {
                store.send(.setupPlayer(url))
            }
        }
        .onReceive(Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()) { _ in
            store.send(.updateTimeStampProgress)
        }
        .onDisappear {
            store.send(.stopPlayer)
        }
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
