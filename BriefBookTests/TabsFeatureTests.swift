//
//  TabsFeatureTests.swift
//  BriefBookTests
//
//  Created by Daniil on 28.07.2024.
//

import ComposableArchitecture
import XCTest

@testable import BriefBook

@MainActor
final class TabsFeatureTests: XCTestCase {
    func testTabSelected() async {
        let store = TestStore(
            initialState: TabsFeature.State(),
            reducer: { TabsFeature() }
        )

        let textTab = TabsFeature.State.SelectedTab.text
        await store.send(.tabSelected(.text)) {
            $0.selectedTab = textTab
        }

        let audioTab = TabsFeature.State.SelectedTab.audio
        await store.send(.tabSelected(.audio)) {
            $0.selectedTab = audioTab
        }
    }
}
