//
//  TabsView.swift
//  BriefBook
//
//  Created by Daniil on 20.07.2024.
//

import SwiftUI
import ComposableArchitecture

struct TabsView: View {
    let store: StoreOf<TabsFeature>

    var body: some View {
        HStack(spacing: 25) {
            TabElement(tab: .audio, image: "headphones", store: store)
                .onTapGesture {
                    store.send(.tabSelected(TabsFeature.State.SelectedTab.audio))
                }

            TabElement(tab: .text, image: "text.alignleft", store: store)
                .onTapGesture {
                    store.send(.tabSelected(TabsFeature.State.SelectedTab.text))
                }
        }
        .frame(width: 100, height: 40)
        .padding(5)
        .background(
            RoundedRectangle(cornerRadius: 60)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
        )
        .animation(.easeInOut, value: store.selectedTab)
    }
}

#Preview {
    TabsView(store: Store(initialState: TabsFeature.State()) {
        TabsFeature()
    })
}
