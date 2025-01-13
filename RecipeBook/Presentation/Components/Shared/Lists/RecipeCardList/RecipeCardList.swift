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
    var onLastListElementAppear: () -> Void
    
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
        isLoading: Binding<Bool> = .constant(false),
        onLastListElementAppear: @escaping () -> Void
    ) {
        self._recipeModels = recipeModels
        self._cardViewType = cardViewType
        self._isLoading = isLoading
        self.onLastListElementAppear = onLastListElementAppear
    }

    var body: some View {
        if isLoading {
            EmptyView()
                .onAppear { onLastListElementAppear() }
            RecipeCardListSkeleton(
                cardViewType: $cardViewType,
                columns: columns,
                spacing: gridSpacing
            ).overlay {
                Rectangle().fill(Color(.clear))
                    .onAppear { onLastListElementAppear() }
            }
            
        } else if recipeModels.isEmpty {
            ContentUnavailableView(
                "No recipes found",
                systemImage: "text.page.badge.magnifyingglass",
                description: Text("Select other filters and try again.")
            )
            .padding(.top, 100)
            .overlay {
                Rectangle().fill(Color(.clear))
                    .onAppear { onLastListElementAppear() }
            }
        } else {
            LazyVGrid(
                columns: columns,
                spacing: gridSpacing
            ) {
                ForEach(recipeModels, id: \.id) { recipeModel in
                    RecipeCard(
                        viewModel: RecipeCardViewModel(
                            recipeModel: recipeModel
                        ),
                        viewType: $cardViewType
                    )
                    .overlay {
                        //TODO: remade offsets
                        if (
                            (recipeModels.firstIndex(where: { $0.id == recipeModel.id } )
                             ?? (recipeModels.count - 2)) == recipeModels.count - 2
                        ) {
                            Rectangle().fill(Color(.clear))
                                .onAppear { onLastListElementAppear() }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    RecipeCardList(
        recipeModels: .constant([]),
        cardViewType: .constant(.grid),
        isLoading: .constant(true),
        onLastListElementAppear: { print("appeared") }
    )
}
