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
            reducer: { AudioPlayerFeature(audioPlayer: AudioPlayerTests()) }
        )
        let totalTime: TimeInterval = 2000
        await store.send(.totalTimeChanged(totalTime)) {
            $0.totalTime = totalTime
        }
    }

    func testTimeStampChanged() async {
        let store = TestStore(
            initialState: AudioPlayerFeature.State(),
            reducer: { AudioPlayerFeature(audioPlayer: AudioPlayerTests()) }
        )
        let newTimeStamp: TimeInterval = 2000
        await store.send(.timeStampChanged(newTimeStamp)) {
            $0.currentTime = newTimeStamp
        }
    }

    func testSpeedChanged() async {
        let store = TestStore(
            initialState: AudioPlayerFeature.State(),
            reducer: { AudioPlayerFeature(audioPlayer: AudioPlayerTests()) }
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
            reducer: { AudioPlayerFeature(audioPlayer: AudioPlayerTests()) }
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
        let audioPlayer = AudioPlayerTests()

        let store = TestStore(
            initialState: AudioPlayerFeature.State(),
            reducer: { AudioPlayerFeature(audioPlayer: audioPlayer) }
        )

        await store.send(.setupPlayer(trackURL)) {
            $0.totalTime = audioPlayer.totalTime
        }

        audioPlayer.currentTime = 10

        await store.send(.rewindTapped) {
            $0.currentTime = expectedCurrentTime
        }
    }

    func testForwardTapped() async {
        let trackURL = Bundle.main.url(forResource: "track1", withExtension: "mp3")!
        let expectedCurrentTime: TimeInterval = 20
        let audioPlayer = AudioPlayerTests()

        let store = TestStore(
            initialState: AudioPlayerFeature.State(),
            reducer: { AudioPlayerFeature(audioPlayer: audioPlayer) }
        )

        await store.send(.setupPlayer(trackURL)) {
            $0.totalTime = audioPlayer.totalTime
        }

        audioPlayer.currentTime = 10

        await store.send(.forwardTapped) {
            $0.currentTime = expectedCurrentTime
        }
    }
}
