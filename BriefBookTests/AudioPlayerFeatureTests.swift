//
//  AudioPlayerFeatureTests.swift
//  BriefBookTests
//
//  Created by Daniil on 26.07.2024.
//

import ComposableArchitecture
import XCTest
import AVFAudio

@testable import BriefBook

@MainActor
final class AudioPlayerFeatureTests: XCTestCase {
    func testTotalTimeChanged() async {
        let store = TestStore(
            initialState: AudioPlayerFeature.State(),
            reducer: { AudioPlayerFeature() }
        )
        let totalTime: TimeInterval = 2000
        await store.send(.totalTimeChanged(totalTime)) {
            $0.totalTime = totalTime
        }
    }

    func testTimeStampChanged() async {
        let store = TestStore(
            initialState: AudioPlayerFeature.State(),
            reducer: { AudioPlayerFeature() }
        )
        let newTimeStamp: TimeInterval = 2000
        await store.send(.timeStampChanged(newTimeStamp)) {
            $0.currentTime = newTimeStamp
        }
    }

    func testSpeedChanged() async {
        let store = TestStore(
            initialState: AudioPlayerFeature.State(),
            reducer: { AudioPlayerFeature() }
        )

        await store.send(.speedChanged) {
            $0.speed = .fast
        }

        await store.send(.speedChanged) {
            $0.speed = .slow
        }

        await store.send(.speedChanged) {
            $0.speed = .normal
        }
    }

    func testPlayPause() async {
        let store = TestStore(
            initialState: AudioPlayerFeature.State(),
            reducer: { AudioPlayerFeature() }
        )

        await store.send(.playPauseTapped) {
            $0.isPlaying = true
        }

        await store.send(.playPauseTapped) {
            $0.isPlaying = false
        }
    }

    func testRewindTapped() async {
        let trackURL = Bundle.main.url(forResource: "track1", withExtension: "mp3")!
        let expectedCurrentTime: TimeInterval = 5

        let store = TestStore(
            initialState: AudioPlayerFeature.State(),
            reducer: { AudioPlayerFeature() }
        )

        await store.send(.setupPlayer(trackURL)) {
            $0.totalTime = store.state.audioPlayer.totalTime
        }

        store.state.audioPlayer.currentTime = 10

        await store.send(.rewindTapped) {
            $0.audioPlayer.currentTime = expectedCurrentTime
            $0.currentTime = expectedCurrentTime
        }
    }

    func testForwardTapped() async {
        let trackURL = Bundle.main.url(forResource: "track1", withExtension: "mp3")!
        let expectedCurrentTime: TimeInterval = 20

        let store = TestStore(
            initialState: AudioPlayerFeature.State(),
            reducer: { AudioPlayerFeature() }
        )

        await store.send(.setupPlayer(trackURL)) {
            $0.totalTime = store.state.audioPlayer.totalTime
        }

        store.state.audioPlayer.currentTime = 10

        await store.send(.forwardTapped) {
            $0.audioPlayer.currentTime = expectedCurrentTime
            $0.currentTime = expectedCurrentTime
        }
    }
}
