//
//  AudioPlayer.swift
//  BriefBook
//
//  Created by Daniil on 01.08.2024.
//

import AVFAudio

class AudioPlayer: NSObject, AudioPlayable {
    static let shared = AudioPlayer()

    private override init() {}

    private var player: AVAudioPlayer?

    var isPlaying: Bool {
        return player?.isPlaying ?? false
    }

    var totalTime: TimeInterval {
        return player?.duration ?? 0.0
    }

    var currentTime: TimeInterval {
        get {
            return player?.currentTime ?? 0.0
        }
        set {
            player?.currentTime = newValue
        }
    }

    var rate: Float {
        get {
            return player?.rate ?? 1.0
        }
        set {
            player?.rate = newValue
        }
    }

    func setupPlayer(with url: URL) throws {
        player = try AVAudioPlayer(contentsOf: url)
        player?.prepareToPlay()
        player?.enableRate = true
    }

    func play() {
        player?.play()
    }

    func pause() {
        player?.pause()
    }

    func stop() {
        player?.stop()
    }

    func rewind(by seconds: TimeInterval) {
        player?.currentTime -= seconds
    }

    func forward(by seconds: TimeInterval) {
        player?.currentTime += seconds
    }
}
