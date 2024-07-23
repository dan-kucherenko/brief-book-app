//
//  Book.swift
//  BriefBook
//
//  Created by Daniil on 22.07.2024.
//

import Foundation
import SwiftUI
import Kingfisher

struct Book {
    let name: String
    let bookImage: String
    let chapters: [String]
    let keyPoints: [String: TimeInterval]
    let audioSumup: URL
    
    var bookImageReady: KFImage {
        KFImage(URL(string: bookImage))
    }
    
    static var mock: Book {
        Book(
            name: "Test Book",
            bookImage: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.freepik.com%2Ffree-photos-vectors%2Fbook&psig=AOvVaw0nVpFzb75GxPrntO5hVU7B&ust=1721842238766000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCJCr7arYvYcDFQAAAAAdAAAAABAI",
            chapters: [
                "Introduction",
                "Chapter 1: Getting Started",
                "Chapter 2: Deep Dive",
                "Chapter 3: Advanced Topics",
                "Conclusion"
            ],
            keyPoints: [
                "Introduction" : 0,
                "Chapter 1: Getting Started" : 120,
                "Chapter 2: Deep Dive" : 600,
                "Chapter 3: Advanced Topics" : 1200,
                "Conclusion" : 1800
            ],
            audioSumup: Bundle.main.url(forResource: "test_audio", withExtension: "mp3")!
        )
    }
}
