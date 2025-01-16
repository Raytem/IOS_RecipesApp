//
//  IngredientsSection.swift
//  RecipeBook
//
//  Created by Daniil on 15.01.25.
//

import SwiftUI

struct IngredientsSection: View {
    var ingredients: [RecipeDetailsModel.ExtendedIngredient]
    
    var body: some View {
        RecipeDetailsSection(title: "Ingredients") {
            ZStack(alignment: .topLeading) {
                Text(getIngredientsString())
                    .lineLimit(2)
                    .foregroundStyle(.gray)
                
                VStack(alignment: .trailing) {
                    Spacer()
                    HStack {
                        Spacer()
                        
                        GradientOverlayContainer(
                            gradientSide: .left,
                            color: .backgroundLayer1
                        ) {
                            CustomButton(
                                title: "full list",
                                color: .primary,
                                size: .small,
                                variant: .text,
                                endIcon: "chevron.right",
                                withPaddings: false,
                                action: {}
                            )
                        }
                    }
                }
                .allowsHitTesting(false)
            }
        } topOutOfPaddingContent: {}
    }
    
    private func getIngredientsString() -> String {
        let str = ingredients
            .map({ $0.name.lowercased() })
            .joined(separator: ", ")
        
        return TextUtil.firstLetterCapitalized(str)
    }
}

#Preview {
    IngredientsSection(
        ingredients: recipeDetailsMockData.extendedIngredients
    )
}
