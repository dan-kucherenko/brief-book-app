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
    var body: some Scene {
        WindowGroup {
            ContentView(
                audioControllersStore: Store(initialState: AudioPlayerFeature.State()) {
                    AudioPlayerFeature()
                },
                tabStore: Store(initialState: TabsFeature.State()) {
                    TabsFeature()
            })
        }
    }
}
