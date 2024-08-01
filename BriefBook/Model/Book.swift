//
//  Book.swift
//  BriefBook
//
//  Created by Daniil on 22.07.2024.
//

import Foundation

struct Book {
    let name: String
    let bookImage: String
    let chapters: [String]
    let audioTracks: [URL?]

    static var mock: Book {
        Book(
            name: "Test Book",
            bookImage: """
            https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.freepik.com%2Ffree-photos-vectors%2Fbook&psig=
            AOvVaw0nVpFzb75GxPrntO5hV
            U7B&ust=1721842238766000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCJCr7arYvYcDFQAAAAAdAAAAABAI
            """,
            chapters: [
                "Introduction",
                "Chapter 1: Getting Started",
                "Chapter 2: Deep Dive",
                "Conclusion"
            ],

            audioTracks: [
                Bundle.main.url(forResource: "track1", withExtension: "mp3"),
                Bundle.main.url(forResource: "track2", withExtension: "mp3"),
                Bundle.main.url(forResource: "track3", withExtension: "mp3"),
                Bundle.main.url(forResource: "track4", withExtension: "mp3")
            ]
        )
    }
}
