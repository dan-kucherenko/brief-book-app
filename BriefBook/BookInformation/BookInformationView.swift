//
//  BookInformationView.swift
//  BriefBook
//
//  Created by Daniil on 22.07.2024.
//

import SwiftUI
import ComposableArchitecture

struct BookInformationView: View {
    let store: StoreOf<BookInformationFeature>

    var body: some View {
        VStack {
            bookImageView
            keyPointsView
            chapterTitleView
        }
    }
}

extension BookInformationView {
    private var bookImageView: some View {
        Image(.bookPhotoPlaceholder)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: 240)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    private var keyPointsView: some View {
        Text("KEY POINT \(store.keypoint) OF \(store.chapters.count)")
            .font(.subheadline)
            .bold()
            .padding(.top, 30)
            .foregroundStyle(.gray)
    }

    private var chapterTitleView: some View {
        Text(store.chapterTitle)
            .font(.callout)
            .multilineTextAlignment(.center)
            .padding(.top, 5)
            .padding(.horizontal, 25)
    }
}

#Preview {
    BookInformationView(store: Store(initialState: BookInformationFeature.State()) {
        BookInformationFeature()
    })
}
