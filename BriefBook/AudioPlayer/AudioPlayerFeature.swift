//
//  AudioPlayerFeature.swift
//  BriefBook
//
//  Created by Daniil on 19.07.2024.
//

import ComposableArchitecture
import AVFAudio

@Reducer
struct AudioPlayerFeature {
    @ObservableState
    struct State: Equatable {
        var isPlaying = false
        var totalTime: TimeInterval = 0.0
        var currentTime: TimeInterval = 0.0
        var speed: Speed = .normal
        var player: AVAudioPlayer?

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
                do {
                    guard let url else { return .none }
                    let player = try AVAudioPlayer(contentsOf: url)
                    player.prepareToPlay()
                    player.enableRate = true
                    state.player = player
                    state.totalTime = player.duration
                    state.speed = .normal
                    state.isPlaying = false
                } catch {
                    print("Error loading audio: \(error)")
                }
                return .none

            case .stopPlayer:
                state.player?.stop()
                return .none

            case .totalTimeChanged(let totalTime):
                state.totalTime = totalTime
                return .none

            case .timeStampChanged(let newTimeStamp):
                state.currentTime = newTimeStamp
                state.player?.currentTime = newTimeStamp
                return .none

            case .updateTimeStampProgress:
                state.currentTime = state.player?.currentTime ?? 0
                return .none

            case .speedChanged:
                state.speed = state.speed.nextSpeed
                state.player?.rate = state.speed.rawValue
                return .none

            case .playPauseTapped:
                if state.isPlaying {
                    state.player?.pause()
                } else {
                    state.player?.play()
                }
                state.isPlaying.toggle()
                return .none

            case .previousTrackTapped:
                return .none

            case .rewindTapped:
                state.player?.currentTime -= 5
                state.currentTime = state.player?.currentTime ?? 0
                return .none

            case .forwardTapped:
                state.player?.currentTime += 10
                state.currentTime = state.player?.currentTime ?? 0
                return .none

            case .nextTrackTapped:
                return .none
            }
        }
    }
}
