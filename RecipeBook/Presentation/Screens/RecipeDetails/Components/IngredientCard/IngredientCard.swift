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
            Text("\(formatAmount(ingredient.amount)) \(ingredient.unit)")
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(.backgroundLayer2)
        .cornerRadius(15)
    }
    
    
    func formatAmount(_ amount: Double) -> String {
        var format = "%.0f"
        if (amount - ceil(amount) != 0) {
            format = "%.2f"
        }
        return String(format: format, amount)
    }
}

#Preview {
    IngredientCard(
        ingredient: recipeDetailsMockData.extendedIngredients[0]
    )
}
