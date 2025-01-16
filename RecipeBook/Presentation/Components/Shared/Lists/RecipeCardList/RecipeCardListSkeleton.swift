//
//  RecipeCardListSkeleton.swift
//  RecipeBook
//
//  Created by Daniil on 10.01.25.
//

import SwiftUI

struct RecipeCardListSkeleton: View {
    @Binding var cardViewType: RecipeCardViewType
    let columns: [GridItem]
    let spacing: CGFloat?
    
    init(
        cardViewType: Binding<RecipeCardViewType> = .constant(.grid),
        columns: [GridItem] = [],
        spacing: CGFloat? = nil
    ) {
        self._cardViewType = cardViewType
        self.columns = columns
        self.spacing = spacing
    }
    
    var body: some View {
        LazyVGrid(
            columns: columns,
            spacing: spacing
        ) {
            ForEach(0..<6, id: \.self) { _ in
                RecipeCardSkeleton(
                    viewType: $cardViewType
                )
                .padding(cardViewType == .list ? 10 : 0)
            }
        }
    }
}

#Preview {
    RecipeCardListSkeleton()
}
