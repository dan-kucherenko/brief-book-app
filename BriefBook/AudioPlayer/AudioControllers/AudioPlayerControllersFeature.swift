//
//  AudioPlayersControllersFeature.swift
//  BriefBook
//
//  Created by Daniil on 21.07.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AudioPlayerControllersFeature {
    @ObservableState
    struct State {
        var isPlaying: Bool = false
    }
    
    enum Action {
        case playPauseTapped
        case previousTrackTapped
        case rewindTapped
        case forwardTapped
        case nextTrackTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .playPauseTapped:
                state.isPlaying.toggle()
                return .none
            case .previousTrackTapped:
                // switch to the previous track
                print("Prev track clicked")
                return .none
            case .rewindTapped:
                // 5 sec backwards
                print("Rewind clicked")
                return .none
            case .forwardTapped:
                // 10 sec forward
                print("Forward clicked")
                return .none
            case .nextTrackTapped:
                // switch to the next track
                print("Next track clicked")
                return .none
            }
        }
    }
}
