//
//  RecipeCardView.swift
//  RecipeBook
//
//  Created by Daniil on 8.01.25.
//

import SwiftUI

struct RecipeCard: View {
    @State public var viewModel: RecipeCardViewModel
    @Binding public var viewType: RecipeCardViewType
    
    private var isStackVertical: Bool {
        getRecipeCardSettings(for: viewType).isStackVertical
   }
    
    private var imageHeight: CGFloat {
       getRecipeCardSettings(for: viewType).imageHeight
   }
   
    private var imageWidth: CGFloat {
       getRecipeCardSettings(for: viewType).imageWidth
    }

    private var cardHeight: CGFloat {
       getRecipeCardSettings(for: viewType).cardHeight
    }

    private var buttonAlignment: Alignment {
       getRecipeCardSettings(for: viewType).buttonAlignment
    }
    
    init(
        viewModel: RecipeCardViewModel,
        viewType: Binding<RecipeCardViewType>
    ) {
        self.viewModel = viewModel
        self._viewType = viewType
    }
    
    var body: some View {
        DynamicStack(
            isVertical: isStackVertical,
            alignment: .leading,
            spacing: 0
        ) {
            // Image block
            CustomAsyncImage(
                url: viewModel.recipeModel.image
            )
            .overlay() {
                LinearGradient(
                    colors: [
                        .black,
                        .clear,
                        .clear,
                        .clear
                    ],
                    startPoint: .bottom,
                    endPoint: .top
                ).opacity(0.7)
                
                VStack(alignment: .leading, spacing: 0) {
                    Spacer()
                    
                    HStack(alignment: .top, spacing: 5) {
                        Image(systemName: "clock")
                        Text("\(viewModel.recipeModel.readyInMinutes) min")
                            .lineLimit(1)
                        Spacer()
                    }
                    .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity)
                .padding(7)
            }
            .frame(width: imageWidth, height: imageHeight)
            .cornerRadius(20)
            .clipped()
            
            // Card info
            VStack(alignment: .leading, spacing: 0) {
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(viewModel.recipeModel.title)
                        .font(.headline)
                        .lineLimit(2)
                        .truncationMode(.tail)
                    
                    Text(
                        viewModel.recipeModel.diets.map({ diet in diet.rawValue }).joined(separator: ", ")
                    )
                        .font(.callout)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    HStack {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.red)
                        Text("\(viewModel.recipeModel.aggregateLikes) likes")
                            .font(.callout)
                            .lineLimit(1)
                    }
                }
                
                Spacer()
                
                CustomButton(
                    title: "Add to saved",
                    size: .medium,
                    startIcon: "bookmark.fill",
                    action: {
                        //TODO
                    }
                )
                .frame(
                    maxWidth: .infinity,
                    alignment: buttonAlignment
                )
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(5)
        }
        .frame(height: cardHeight)
        .background(.clear)
    }
    
}

#Preview {
    RecipeCard(
        viewModel: RecipeCardViewModel(
            recipeModel: recipeCardMockData[0]
        ),
        viewType: .constant(.grid)
    )
}
