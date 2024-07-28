//
//  AppFeature.swift
//  BriefBook
//
//  Created by Daniil on 23.07.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AppFeature {
    struct State: Equatable {
        var bookInfoState = BookInformationFeature.State()
        var audioState = AudioPlayerFeature.State()
        var tabsState = TabsFeature.State()
    }

    enum Action {
        case bookInfoAction(BookInformationFeature.Action)
        case audioAction(AudioPlayerFeature.Action)
        case tabAction(TabsFeature.Action)
    }

    var body: some ReducerOf<Self> {
        Scope(state: \.bookInfoState, action: \.bookInfoAction) {
            BookInformationFeature()
        }
        Scope(state: \.audioState, action: \.audioAction) {
            AudioPlayerFeature()
        }
        Scope(state: \.tabsState, action: \.tabAction) {
            TabsFeature()
        }

        Reduce { state, action in
            switch action {
            case .audioAction(let audioAction):
                switch audioAction {
                case .previousTrackTapped:
                    return .send(.bookInfoAction(.keyPointMoveBackward))
                case .nextTrackTapped:
                    return .send(.bookInfoAction(.keyPointMoveForward))
                default:
                    return .none
                }

            case .tabAction:
                return .none

            case .bookInfoAction(let bookInfoAction):
                switch bookInfoAction {
                case .setInitialValues(let book):
                    state.bookInfoState = BookInformationFeature.State(
                        keypoint: 1,
                        chapterTitle: book.chapters.first!,
                        chapters: book.chapters,
                        audioTracks: book.audioTracks
                    )
                    return .none

                case .keyPointChanged(let newTrack):
                    return .send(.audioAction(.setupPlayer(newTrack!)))

                default:
                    return .none
                }
            }
        }
    }
}
