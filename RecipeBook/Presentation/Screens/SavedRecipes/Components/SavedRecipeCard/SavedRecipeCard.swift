//
//  SavedRecipeCard.swift
//  RecipeBook
//
//  Created by Daniil on 16.01.25.
//

import SwiftUI

struct SavedRecipeCard: View {
    var savedRecipeModel: SavedRecipeModel
    @Binding var isNavigationLinkEnabled: Bool
    
    var cardHeight: CGFloat = 180
    
    init(
        savedRecipeModel: SavedRecipeModel,
        isNavigationLinkEnabled: Binding<Bool> = .constant(true)
    ) {
        self.savedRecipeModel = savedRecipeModel
        self._isNavigationLinkEnabled = isNavigationLinkEnabled
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            CustomAsyncImage(
                url: savedRecipeModel.image,
                contentMode: .fill
            )
            .frame(height: cardHeight)
           
            LinearGradient(
                colors: [
                    .neaturalBlack,
                    .clear,
                ],
                startPoint: .bottom,
                endPoint: .top
            )
            .opacity(0.9)
          
            HStack(alignment: .bottom, spacing: 10) {
                Text(savedRecipeModel.title)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .font(.title3)
                    .fontWeight(.bold)
                    .minimumScaleFactor(0.85)
                    .lineSpacing(4)
                    .foregroundStyle(.neaturalWhite)
                
                Spacer()
                
                HStack() {
                    HStack(alignment: .top, spacing: 5) {
                        Image(systemName: "clock")
                        Text(TimeUtil.fromMinutesToLocalizedTimeString(min: savedRecipeModel.readyInMinutes))
                            .lineLimit(1)
                    }
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundStyle(.neaturalGray4)
                    
                    Circle()
                        .fill(Color(.neaturalWhite))
                        .frame(width: 30, height: 30)
                        .overlay {
                            Image(systemName: "bookmark")
                                .foregroundStyle(.primary50)
                        }
                }
            }
            .padding(15)
        }
        .frame(height: cardHeight)
        .cornerRadius(25)
        .clipped()
        .contentShape(Rectangle())
        .overlay {
            if isNavigationLinkEnabled {
                NavigationLink(
                    destination: RecipeDetailsScreen(
                        viewModel: RecipeDetailsViewModel(
                            recipeId: savedRecipeModel.id,
                            recipeDetailsPreview: .init(
                                title: savedRecipeModel.title,
                                image: savedRecipeModel.image
                            )
                        )
                    ),
                    label: { EmptyView() }
                )
                .opacity(0)
            }
        }
    }
}

#Preview {
    SavedRecipeCard(
        savedRecipeModel: savedRecipeMockData[0]
    )
}
