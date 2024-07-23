//
//  TabsFeature.swift
//  BriefBook
//
//  Created by Daniil on 20.07.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct TabsFeature {
    @ObservableState
    struct State: Equatable {
        var selectedTab: SelectedTab = .audio
        
        enum SelectedTab {
            case audio
            case text
        }
    }
    
    enum Action {
        case tabSelected(State.SelectedTab)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .tabSelected(tab):
                state.selectedTab = tab
                return .none
            }
        }
    }
}
