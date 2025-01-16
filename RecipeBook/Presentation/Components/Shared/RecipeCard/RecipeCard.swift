//
//  RecipeCardView.swift
//  RecipeBook
//
//  Created by Daniil on 8.01.25.
//

import SwiftUI

struct RecipeCard: View {
    @State public var viewModel: RecipeCardViewModel
    @Binding var viewType: RecipeCardViewType
    
    private var isStackVertical: Bool {
        RecipeCardSettings.get(for: viewType).isStackVertical
   }
    
    private var imageHeight: CGFloat {
        RecipeCardSettings.get(for: viewType).imageHeight
   }
   
    private var imageWidth: CGFloat {
        RecipeCardSettings.get(for: viewType).imageWidth
    }

    private var cardHeight: CGFloat {
        RecipeCardSettings.get(for: viewType).cardHeight
    }

    private var buttonAlignment: Alignment {
        RecipeCardSettings.get(for: viewType).buttonAlignment
    }
    
    var body: some View {
        NavigationLink(
            destination: {
                RecipeDetailsScreen(
                    viewModel: .init(
                        recipeId: viewModel.recipeModel.id,
                        recipeDetailsPreview: .init(
                            title: viewModel.recipeModel.title,
                            image: viewModel.recipeModel.image
                        )
                    )
                )
            }
        ) {
            DynamicStack(
                isVertical: isStackVertical,
                horizontalAlignment: .leading,
                verticalAlignment: .top,
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
                            Text(TimeUtil.fromMinutesToLocalizedTimeString(min: viewModel.recipeModel.readyInMinutes))
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
                            .foregroundStyle(Color(.label))
                            .lineLimit(2)
                            .truncationMode(.tail)
                            .multilineTextAlignment(.leading)
                        
                        if !viewModel.recipeModel.diets.isEmpty {
                            Text(
                                viewModel.recipeModel.diets
                                    .map({ diet in diet.displayName })
                                    .sorted(by: <)
                                    .joined(separator: ", ")
                            )
                                .font(.callout)
                                .foregroundStyle(Color(.label))
                                .lineLimit(1)
                                .truncationMode(.tail)
                        }
                        
                        HStack {
                            Image(systemName: "heart.fill")
                                .foregroundStyle(.red)
                            Text("\(viewModel.recipeModel.aggregateLikes) likes")
                                .font(.callout)
                                .lineLimit(1)
                                .foregroundStyle(.gray)
                        }
                    }
                    
                    Spacer()
                    
                    CustomButton(
                        title: "Add to saved",
                        size: .medium,
                        startIcon: "bookmark.fill",
                        action: handleAddToSavedButtonClick
                    )
                    .frame(
                        maxWidth: .infinity,
                        alignment: buttonAlignment
                    )
                    
                }
                .padding(5)
            }
            .frame(height: cardHeight)
            .background(.clear)
        }
    }
    
    func handleAddToSavedButtonClick() {
        viewModel.addToSaved()
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
