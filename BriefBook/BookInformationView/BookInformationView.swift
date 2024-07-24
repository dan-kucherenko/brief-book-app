//
//  BookInformationView.swift
//  BriefBook
//
//  Created by Daniil on 22.07.2024.
//

import SwiftUI
import ComposableArchitecture

struct BookInformationView: View {
    let book: Book
    let store: StoreOf<BookInformationFeature>

    var body: some View {
        VStack {
            Image(.bookPhotoPlaceholder)
                .resizable()
                .scaledToFit()
                .frame(width: 240)
            Text("KEY POINT \(store.keypoint) OF \(store.keyPoints.count)")
                .font(.subheadline)
                .bold()
                .padding(.top, 30)
                .foregroundStyle(.gray)
            Text(store.chapterTitle)
                .font(.callout)
                .multilineTextAlignment(.center)
                .padding(.top, 5)
                .padding(.horizontal, 25)
        }
    }
}

#Preview {
    BookInformationView(book: .mock, store: Store(initialState: BookInformationFeature.State()) {
        BookInformationFeature()
    })
}
