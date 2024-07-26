//
//  BookInformationFeature.swift
//  BriefBook
//
//  Created by Daniil on 23.07.2024.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct BookInformationFeature {

    @ObservableState
    struct State: Equatable {
        var keypoint = 1
        var chapterTitle: String = ""
        var chapters: [String] = []
        var audioTracks: [URL] = []
    }

    enum Action {
        case setInitialValues(book: Book)
        case keyPointMoveForward
        case keyPointMoveBackward
        case chapterTitleChanged(String)
        case keyPointChanged(URL?)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .setInitialValues(let book):
                state.keypoint = 1
                state.chapters = book.chapters
                state.chapterTitle = book.chapters.first!
                state.audioTracks = book.audioTracks
                return .none

            case .keyPointMoveForward:
                if state.keypoint < state.chapters.count {
                    state.keypoint += 1
                    state.chapterTitle = state.chapters[state.keypoint - 1]
                    let newTrack = state.audioTracks[state.keypoint - 1]
                    return .send(.keyPointChanged(newTrack))
                }
                return .none

            case .keyPointMoveBackward:
                if state.keypoint > 1 {
                    state.keypoint -= 1
                    state.chapterTitle = state.chapters[state.keypoint - 1]
                    let newTrack = state.audioTracks[state.keypoint - 1]
                    return .send(.keyPointChanged(newTrack))
                }
                return .none

            case .chapterTitleChanged(let title):
                state.chapterTitle = title
                return .none

            case .keyPointChanged:
                return .none
            }
        }
    }
}
