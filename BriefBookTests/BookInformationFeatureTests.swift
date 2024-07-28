//
//  BookInformationFeatureTests.swift
//  BriefBookTests
//
//  Created by Daniil on 28.07.2024.
//

import ComposableArchitecture
import XCTest

@testable import BriefBook

@MainActor
final class BookInformationFeatureTests: XCTestCase {
    func testSetInitialValues() async {
        let store = TestStore(
            initialState: BookInformationFeature.State(),
            reducer: { BookInformationFeature() }
        )

        await store.send(.setInitialValues(book: .mock)) {
            $0.keypoint = 1
            $0.chapterTitle = Book.mock.chapters.first ?? ""
            $0.chapters = Book.mock.chapters
            $0.audioTracks = Book.mock.audioTracks
        }
    }

    func testKeyPointMoveForward() async {
        var initialState = BookInformationFeature.State()
        initialState.chapters = Book.mock.chapters
        initialState.audioTracks = Book.mock.audioTracks

        let store = TestStore(
            initialState: initialState,
            reducer: { BookInformationFeature() }
        )

        await store.send(.keyPointMoveForward) {
            $0.keypoint = 2
            $0.chapterTitle = $0.chapters[$0.keypoint - 1]
        }

        await store.receive(\.keyPointChanged)
    }

    func testKeyPointMoveBackward() async {
        var initialState = BookInformationFeature.State()
        initialState.keypoint = 2
        initialState.chapters = Book.mock.chapters
        initialState.audioTracks = Book.mock.audioTracks

        let store = TestStore(
            initialState: initialState,
            reducer: { BookInformationFeature() }
        )

        await store.send(.keyPointMoveBackward) {
            $0.keypoint = 1
            $0.chapterTitle = $0.chapters[$0.keypoint - 1]
        }

        await store.receive(\.keyPointChanged)
    }

    func testChapterTitleChanged() async {
        let store = TestStore(
            initialState: BookInformationFeature.State(),
            reducer: { BookInformationFeature() }
        )

        let testTitle = "Test Title"
        await store.send(.chapterTitleChanged(testTitle)) {
            $0.chapterTitle = testTitle
        }
    }
}
