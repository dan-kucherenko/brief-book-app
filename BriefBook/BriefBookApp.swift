//
//  BriefBookApp.swift
//  BriefBook
//
//  Created by Daniil on 16.07.2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct BriefBookApp: App {
    static let store = Store(initialState: AppFeature.State()) {
      AppFeature()
    }
    var body: some Scene {
        WindowGroup {
            ContentView(book: .mock, store: BriefBookApp.store)
        }
    }
}
