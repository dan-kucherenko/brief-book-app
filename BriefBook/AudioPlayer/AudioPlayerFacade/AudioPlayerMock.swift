//
//  AudioPlayerMock.swift
//  BriefBook
//
//  Created by Daniil on 01.08.2024.
//

import Foundation

class AudioPlayerMock: NSObject, AudioPlayable {
    var isPlaying: Bool = false
    var totalTime: TimeInterval = 0.0
    var currentTime: TimeInterval = 0.0
    var rate: Float = 0.0

    func setupPlayer(with url: URL) throws {}
    func play() {}
    func pause() {}
    func stop() {}
    func rewind(by seconds: TimeInterval) {}
    func forward(by seconds: TimeInterval) {}
}
