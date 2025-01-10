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
        ScrollView(.vertical) {
            if isLoading {
                RecipeCardListSkeleton(viewType: $cardViewType)
            } else if recipeModels.isEmpty {
                ContentUnavailableView(
                    "No recipes found",
                    systemImage: "text.page.badge.magnifyingglass",
                    description: Text("Select other filters and try again.")
                )
                .padding(.top, 100)
            } else {
                LazyVGrid(
                    columns: Array(
                        repeating: GridItem(.flexible(), spacing: 2),
                        count: cardViewType == .grid ? 2 : 1
                    ),
                    spacing: 10
                ) {
                    ForEach(recipeModels, id: \.id) { recipeModel in
                        RecipeCard(
                            viewModel: RecipeCardViewModel(recipeModel: recipeModel),
                            viewType: $cardViewType
                        )
                    }
                }
                .padding()
                .background(Color(uiColor: .backgroundMain))
            }
        }
        .background(Color(uiColor: .backgroundMain))
    }
}

#Preview {
    RecipeCardList(
        recipeModels: .constant([]),
        cardViewType: .constant(.grid),
        isLoading: .constant(false)
    )
}
