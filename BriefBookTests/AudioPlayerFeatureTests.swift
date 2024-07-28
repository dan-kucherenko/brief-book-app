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

    func testPreviousTrackTapped() async {
        let trackURLs = [
            Bundle.main.url(forResource: "track1", withExtension: "mp3")!,
            Bundle.main.url(forResource: "track2", withExtension: "mp3")!
        ]

        var initialState = AudioPlayerFeature.State()
        initialState.currentTrackIndex = 1
        initialState.tracks = trackURLs

        let store = TestStore(
            initialState: initialState,
            reducer: { AudioPlayerFeature() }
        )
        store.exhaustivity = .off

        await store.send(.previousTrackTapped) {
            $0.currentTrackIndex = 0
        }
    }

    func testRewindTapped() async {
        let trackURL = Bundle.main.url(forResource: "track1", withExtension: "mp3")!
        guard let player = try? AVAudioPlayer(contentsOf: trackURL) else { return }
        player.prepareToPlay()
        player.enableRate = true
        player.currentTime = 10

        let expectedCurrentTime: TimeInterval = 5

        let store = TestStore(
            initialState: AudioPlayerFeature.State(player: player),
            reducer: { AudioPlayerFeature() }
        )

        await store.send(.rewindTapped) {
            $0.player?.currentTime = expectedCurrentTime
            $0.currentTime = expectedCurrentTime
        }
    }

    func testForwardTapped() async {
        let trackURL = Bundle.main.url(forResource: "track1", withExtension: "mp3")!
        guard let player = try? AVAudioPlayer(contentsOf: trackURL) else { return }
        player.prepareToPlay()
        player.enableRate = true
        player.currentTime = 10

        let expectedCurrentTime: TimeInterval = 20

        let store = TestStore(
            initialState: AudioPlayerFeature.State(player: player),
            reducer: { AudioPlayerFeature() }
        )

        await store.send(.forwardTapped) {
            $0.player?.currentTime = expectedCurrentTime
            $0.currentTime = expectedCurrentTime
        }
    }

    func testNextTrackTapped() async {
        let trackURLs = [
            Bundle.main.url(forResource: "track1", withExtension: "mp3")!,
            Bundle.main.url(forResource: "track2", withExtension: "mp3")!
        ]

        var initialState = AudioPlayerFeature.State(isPlaying: true)
        initialState.currentTrackIndex = 0
        initialState.tracks = trackURLs

        let store = TestStore(
            initialState: initialState,
            reducer: { AudioPlayerFeature() }
        )
        store.exhaustivity = .off

        await store.send(.nextTrackTapped) {
            $0.currentTrackIndex = 1
        }
    }
}
