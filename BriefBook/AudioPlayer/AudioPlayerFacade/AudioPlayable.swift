//
//  AudioPlayable.swift
//  BriefBook
//
//  Created by Daniil on 01.08.2024.
//

import Foundation

protocol AudioPlayable: Equatable, NSObject {
    var isPlaying: Bool { get }
    var totalTime: TimeInterval { get }
    var currentTime: TimeInterval { get set }
    var rate: Float { get set }

    func setupPlayer(with url: URL) throws
    func play()
    func pause()
    func stop()
    func rewind(by seconds: TimeInterval)
    func forward(by seconds: TimeInterval)
}
