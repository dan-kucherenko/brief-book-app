//
//  ContentView.swift
//  BriefBook
//
//  Created by Daniil on 16.07.2024.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    let book: Book
    let store: StoreOf<AppFeature>

    var body: some View {
        VStack {
            BookInformationView(store: store.scope(state: \.bookInfoState, action: \.bookInfoAction))

            AudioPlayerView(
                store: store.scope(state: \.audioState, action: \.audioAction),
                url: book.audioTracks.first!
            )
            .padding()

            TabsView(store: store.scope(state: \.tabsState, action: \.tabAction))
                .padding(.top, 40)
        }
        .onAppear {
            store.send(.bookInfoAction(.setInitialValues(book: book)))
        }
    }
}

#Preview {
    ContentView(book: .mock, store: Store(initialState: AppFeature.State()) {
        AppFeature()
    })
}
