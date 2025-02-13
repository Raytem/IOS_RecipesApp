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
    var onScrollTargetAppear: () -> Void
    
    let gridSpacing: CGFloat = 15
    
    private var columns: [GridItem] {
        Array(
            repeating: GridItem(.flexible(), spacing: 2),
            count: cardViewType == .grid ? 2 : 1
        )
    }
    
    init(
        recipeModels: Binding<[RecipeModel]> = .constant([]),
        cardViewType: Binding<RecipeCardViewType> = .constant(.grid),
        isLoading: Binding<Bool> = .constant(false),
        onScrollTargetAppear: @escaping () -> Void
    ) {
        self._recipeModels = recipeModels
        self._cardViewType = cardViewType
        self._isLoading = isLoading
        self.onScrollTargetAppear = onScrollTargetAppear
    }

    var body: some View {
        if isLoading {
            EmptyView()
                .onAppear { onScrollTargetAppear() }
            RecipeCardListSkeleton(
                cardViewType: $cardViewType,
                columns: columns,
                spacing: gridSpacing
            ).overlay {
                Rectangle().fill(Color(.clear))
                    .onAppear { onScrollTargetAppear() }
            }
            
        } else if recipeModels.isEmpty && !isLoading {
            ContentUnavailableView(
                "No recipes found",
                systemImage: "text.page.badge.magnifyingglass"
            )
            .padding(.top, 100)
            .overlay {
                Rectangle().fill(Color(.clear))
                    .onAppear { onScrollTargetAppear() }
            }
        } else {
            LazyVGrid(
                columns: columns,
                spacing: gridSpacing
            ) {
                ForEach(recipeModels, id: \.id) { recipeModel in
                    NavigationLink(
                        destination: {
                            RecipeDetailsScreen(
                                viewModel: .init(
                                    recipeId: recipeModel.id,
                                    recipeDetailsPreview: .init(
                                        title: recipeModel.title,
                                        image: recipeModel.image
                                    )
                                )
                            )
                        }
                    ) {
                        RecipeCard(
                            viewModel: RecipeCardViewModel(
                                recipeModel: recipeModel
                            ),
                            viewType: $cardViewType
                        )
                        .overlay {
                            if (recipeModel == recipeModels.last) {
                                Rectangle().fill(Color(.clear))
                                    .onAppear { onScrollTargetAppear() }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, cardViewType == .list ? 10 : 0)
        }
    }
}

#Preview {
    RecipeCardList(
        recipeModels: .constant(recipeCardMockData),
        cardViewType: .constant(.grid),
        isLoading: .constant(true),
        onScrollTargetAppear: { print("appeared") }
    )
}
