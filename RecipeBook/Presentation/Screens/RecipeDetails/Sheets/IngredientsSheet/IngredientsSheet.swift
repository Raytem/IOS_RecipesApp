//
//  IngredientsSheet.swift
//  RecipeBook
//
//  Created by Daniil on 15.01.25.
//

import SwiftUI

struct IngredientsSheet: View {
    var servings: Int
    var ingredients: [RecipeDetailsModel.ExtendedIngredient]
    
    var body: some View {
        CustomPresentationSheet(
            title: "Ingredients"
        ) {
            VStack(spacing: 30) {
                HStack {
                    HStack {
                        Image(systemName: "fork.knife")
                        Text("\(servings) servings")
                    }
                    Spacer()
                    Text("\(ingredients.count) items")
                }
                .foregroundStyle(.gray)
                
                VStack(spacing: 10) {
                    ForEach(ingredients, id: \.id) { ingredient in
                        IngredientCard(ingredient: ingredient)
                    }
                }
            }
            .padding(.top, 20)
        }
    }
}

#Preview {
    IngredientsSheet(
        servings: 1,
        ingredients: recipeDetailsMockData.extendedIngredients
    )
}
