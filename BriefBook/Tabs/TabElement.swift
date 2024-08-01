//
//  TabElement.swift
//  BriefBook
//
//  Created by Daniil on 27.07.2024.
//

import SwiftUI
import ComposableArchitecture

struct TabElement: View {
    let tab: TabsFeature.State.SelectedTab
    let image: String
    let store: StoreOf<TabsFeature>

    private let tabElementWidth: CGFloat = 40
    private let tabElementHeight: CGFloat = 40
    private let iconFontSize: CGFloat = 20

    var body: some View {
        ZStack {
            if store.selectedTab == tab {
                circleFill
            }
            tabImage
        }
    }
}

extension TabElement {
    private var circleFill: some View {
        Circle()
            .fill(Color.blue)
            .frame(width: tabElementWidth, height: tabElementHeight)
    }

    private var tabImage: some View {
        Image(systemName: image)
            .frame(width: tabElementWidth, height: tabElementHeight)
            .font(.system(size: iconFontSize))
            .foregroundColor(store.selectedTab == tab ? .white : .primary)
    }
}

#Preview {
    TabElement(tab: .text, image: "headphones", store: Store(initialState: TabsFeature.State()) {
        TabsFeature()
    })
}
