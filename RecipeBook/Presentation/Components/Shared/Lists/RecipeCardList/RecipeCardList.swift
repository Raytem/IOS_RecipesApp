//
//  RecipeCardList.swift
//  RecipeBook
//
//  Created by Daniil on 10.01.25.
//

import SwiftUI

struct RecipeCardList: View {
    @Binding var recipeModels: [RecipeModel]
    @Binding var cardViewType: RecipeCardViewType
    @Binding var isLoading: Bool
    
    let gridSpacing: CGFloat = 10
    
    private var columns: [GridItem] {
        Array(
            repeating: GridItem(.flexible(), spacing: 2),
            count: cardViewType == .grid ? 2 : 1
        )
    }
    
    init(
        recipeModels: Binding<[RecipeModel]> = .constant([]),
        cardViewType: Binding<RecipeCardViewType> = .constant(.grid),
        isLoading: Binding<Bool> = .constant(false)
    ) {
        self._recipeModels = recipeModels
        self._cardViewType = cardViewType
        self._isLoading = isLoading
    }
    
    var body: some View {
        if isLoading {
            RecipeCardListSkeleton(
                cardViewType: $cardViewType,
                columns: columns,
                spacing: gridSpacing
            )
        } else if recipeModels.isEmpty {
            ContentUnavailableView(
                "No recipes found",
                systemImage: "text.page.badge.magnifyingglass",
                description: Text("Select other filters and try again.")
            )
            .padding(.top, 100)
        } else {
            LazyVGrid(
                columns: columns,
                spacing: gridSpacing
            ) {
                ForEach(recipeModels, id: \.id) { recipeModel in
                    RecipeCard(
                        viewModel: RecipeCardViewModel(recipeModel: recipeModel),
                        viewType: $cardViewType
                    )
                }
            }
        }
    }
}

#Preview {
    RecipeCardList(
        recipeModels: .constant([]),
        cardViewType: .constant(.grid),
        isLoading: .constant(true)
    )
}
