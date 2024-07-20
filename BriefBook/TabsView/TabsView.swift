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
    
    private let audioIcon = "headphones"
    private let textIcon = "text.alignleft"
    private let tabElementWidth: CGFloat = 40
    private let tabElementHeight: CGFloat = 40
    private let iconFontSize: CGFloat = 20
    private let tabsViewWidth: CGFloat = 100
    
    var body: some View {
        HStack (spacing: 25) {
            ZStack {
                if store.selectedTab == .audio {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: tabElementWidth, height: tabElementHeight)
                        .animation(.easeInOut, value: store.selectedTab)
                }
                Image(systemName: audioIcon)
                    .frame(width: tabElementWidth, height: tabElementHeight)
                    .foregroundColor(store.selectedTab == TabsFeature.State.SelectedTab.audio ? .white : .black)
                    .font(.system(size: iconFontSize))
                    .animation(.easeInOut, value: store.selectedTab)
            }
            .onTapGesture {
                store.send(.tabSelected(TabsFeature.State.SelectedTab.audio))
            }
            
            ZStack {
                if store.selectedTab == .text {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: tabElementWidth, height: tabElementHeight)
                        .animation(.easeInOut, value: store.selectedTab)
                }
                Image(systemName: textIcon)
                    .frame(width: tabElementWidth, height: tabElementHeight)
                    .foregroundColor(store.selectedTab == TabsFeature.State.SelectedTab.text ? .white : .black)
                    .font(.system(size: iconFontSize))
                    .animation(.easeInOut, value: store.selectedTab)
            }
            .onTapGesture {
                store.send(.tabSelected(TabsFeature.State.SelectedTab.text))
            }
        }
        .frame(width: 100, height: tabElementHeight)
        .padding(5)
        .background(
            RoundedRectangle(cornerRadius: 60)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                .background(Color.white.cornerRadius(25))
        )
        .animation(.easeInOut, value: store.selectedTab)
    }
}

#Preview {
    TabsView(
        store: Store(initialState: TabsFeature.State()) {
            TabsFeature()
        }
    )
}
