//
//  BookInformationFeature.swift
//  BriefBook
//
//  Created by Daniil on 23.07.2024.
//

import SwiftUI
import ComposableArchitecture
import Kingfisher

@Reducer
struct BookInformationFeature {
    @ObservableState
    struct State: Equatable {
        var keypoint = 1
        var keyPoints: [String: TimeInterval] = [:]
        var chapterTitle: String = ""
        var chapters: [String] = []
    }

    enum Action {
        case setInitialValues(book: Book)
        case keyPointMoveForward
        case keyPointMoveBackward
        case chapterTitleChanged(String)
        case keyPointChanged(TimeInterval)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .setInitialValues(let book):
                state.keypoint = 1
                state.chapters = book.chapters
                state.chapterTitle = book.chapters.first!
                state.keyPoints = book.keyPoints
                return .none
            case .keyPointMoveForward:
                if state.keypoint < state.keyPoints.count {
                    state.keypoint += 1
                    state.chapterTitle = state.chapters[state.keypoint - 1]
                    let newTime = state.keyPoints[state.chapterTitle] ?? 0
                    return .send(.keyPointChanged(newTime))
                }
                return .none
            case .keyPointMoveBackward:
                if state.keypoint > 1 {
                    state.keypoint -= 1
                    state.chapterTitle = state.chapters[state.keypoint - 1]
                    let newTime = state.keyPoints[state.chapterTitle] ?? 0
                    return .send(.keyPointChanged(newTime))
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
