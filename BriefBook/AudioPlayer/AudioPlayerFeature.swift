//
//  AudioPlayerFeature.swift
//  BriefBook
//
//  Created by Daniil on 19.07.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AudioPlayerFeature {
    var audioPlayer: any AudioPlayable

    @ObservableState
    struct State: Equatable {
        var isPlaying = false
        var totalTime: TimeInterval = 0.0
        var currentTime: TimeInterval = 0.0
        var speed: Speed = .normal

        enum Speed: Float {
            case slow = 0.5
            case normal = 1
            case fast = 1.5

            var formatted: String {
                return switch self {
                case .slow: "0.5"
                case .normal: "1"
                case .fast: "1.5"
                }
            }

            var nextSpeed: Speed {
                return switch self {
                case .slow: .normal
                case .normal: .fast
                case .fast: .slow
                }
            }
        }
    }

    enum Action {
        case setupPlayer(URL?)
        case stopPlayer
        case totalTimeChanged(TimeInterval)
        case timeStampChanged(TimeInterval)
        case updateTimeStampProgress
        case speedChanged
        case previousTrackTapped
        case rewindTapped
        case playPauseTapped
        case forwardTapped
        case nextTrackTapped
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .setupPlayer(let url):
                guard let url else { return .none }
                do {
                    try audioPlayer.setupPlayer(with: url)
                    state.totalTime = audioPlayer.totalTime
                    state.speed = .normal
                    state.isPlaying = false
                } catch {
                    print("Error loading audio: \(error)")
                }
                return .none

            case .stopPlayer:
                audioPlayer.stop()
                return .none

            case .totalTimeChanged(let totalTime):
                state.totalTime = totalTime
                return .none

            case .timeStampChanged(let newTimeStamp):
                state.currentTime = newTimeStamp
                audioPlayer.currentTime = newTimeStamp
                return .none

            case .updateTimeStampProgress:
                state.currentTime = audioPlayer.currentTime
                return .none

            case .speedChanged:
                state.speed = state.speed.nextSpeed
                audioPlayer.rate = state.speed.rawValue
                return .none

            case .playPauseTapped:
                if state.isPlaying {
                    audioPlayer.pause()
                } else {
                    audioPlayer.play()
                }
                state.isPlaying.toggle()
                return .none

            case .previousTrackTapped:
                return .none

            case .rewindTapped:
                audioPlayer.rewind(by: 5)
                state.currentTime = audioPlayer.currentTime
                return .none

            case .forwardTapped:
                audioPlayer.forward(by: 10)
                state.currentTime = audioPlayer.currentTime
                return .none

            case .nextTrackTapped:
                return .none
            }
        }
    }
}
