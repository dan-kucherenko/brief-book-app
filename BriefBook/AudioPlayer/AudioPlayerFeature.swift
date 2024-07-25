//
//  AudioPlayerFeature.swift
//  BriefBook
//
//  Created by Daniil on 19.07.2024.
//

import Foundation
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
        var tracks: [URL] = []
        var currentTrackIndex = 0

        enum Speed: Float {
            case slow = 0.5
            case normal = 1
            case fast = 1.5

            var formatted: String {
                switch self {
                case .slow:
                    return "0.5"
                case .normal:
                    return "1"
                case .fast:
                    return "1.5"
                }
            }
        }
    }

    enum Action {
        case setupPlayer(URL)
        case playerInitialized(Result<AVAudioPlayer, Error>)
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
                    return .run { send in
                        do {
                            let player = try AVAudioPlayer(contentsOf: url)
                            player.prepareToPlay()
                            player.enableRate = true
                            await send(.playerInitialized(.success(player)))
                        } catch {
                            await send(.playerInitialized(.failure(error)))
                        }
                    }

                case .playerInitialized(let result):
                    switch result {
                    case .success(let player):
                        state.player = player
                        state.totalTime = player.duration
                        state.speed = .normal
                        state.isPlaying = false
                    case .failure(let error):
                        print("Error loading audio: \(error)")
                    }
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
                    state.speed = nextSpeed(currentSpeed: state.speed)
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
                    if state.currentTrackIndex > 0 {
                        state.currentTrackIndex -= 1
                        let newTrack = state.tracks[state.currentTrackIndex]
                        return .send(.setupPlayer(newTrack))
                    }
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
                    if state.currentTrackIndex < state.tracks.count - 1 {
                        state.currentTrackIndex += 1
                        let newTrack = state.tracks[state.currentTrackIndex]
                        return .send(.setupPlayer(newTrack))
                    }
                    return .none
                }
            }
        }

    // MARK: - Function for getting the next speed for audio
    private func nextSpeed(currentSpeed: State.Speed) -> State.Speed {
        switch currentSpeed {
        case .slow:
            return .normal
        case .normal:
            return .fast
        case .fast:
            return .slow
        }
    }
}
