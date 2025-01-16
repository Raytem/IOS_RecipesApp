//
//  IngredientCard.swift
//  RecipeBook
//
//  Created by Daniil on 15.01.25.
//

import SwiftUI

struct IngredientCard: View {
    var ingredient: RecipeDetailsModel.ExtendedIngredient
    
    var body: some View {
        HStack(spacing: 20) {
            CustomAsyncImage(
                url: ingredient.image,
                background: {AnyView(Color(.white))}
            )
                .frame(width: 80, height: 80)
                .cornerRadius(12)
                .clipped()

            Text(TextUtil.firstLetterCapitalized(ingredient.name))
                .font(.headline)

            Spacer()
            Text("\(NumberUtil.getFormattedNumber(ingredient.amount)) \(ingredient.unit)")
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(.backgroundLayer2)
        .cornerRadius(15)
    }
}

#Preview {
    IngredientCard(
        ingredient: recipeDetailsMockData.extendedIngredients[0]
    )
}
