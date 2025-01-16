//
//  IngredientsSheet.swift
//  RecipeBook
//
//  Created by Daniil on 15.01.25.
//

import SwiftUI

struct IngredientsAndCookingStepsSheet: View {
    enum ActiveTab {
        case ingredients, cookingSteps
    }
    
    var servings: Int
    var ingredients: [RecipeDetailsModel.ExtendedIngredient]
    var cookingSteps: [RecipeDetailsModel.CookingStep]
    
    @State var activeTab: ActiveTab = .ingredients
    
    var body: some View {
        CustomPresentationSheet(
            title: "Ingredients & cooking"
        ) {
            VStack(spacing: 30) {
                HStack {
                    HStack {
                        Image(systemName: "fork.knife")
                        Text("\(servings) servings")
                    }
                    Spacer()
                    Text("\(ingredients.count) ingredients")
                }
                .foregroundStyle(.gray)
                
                Picker("", selection: $activeTab) {
                    Text("Ingredients").tag(ActiveTab.ingredients)
                    Text("Cooking steps").tag(ActiveTab.cookingSteps)
                }
                .pickerStyle(.segmented)
                
                switch activeTab {
                case .ingredients:
                    VStack(spacing: 10) {
                        ForEach(ingredients, id: \.id) { ingredient in
                            IngredientCard(ingredient: ingredient)
                        }
                    }
                case .cookingSteps:
                    VStack(spacing: 10) {
                        ForEach(
                            cookingSteps.sorted { $0.number < $1.number},
                            id: \.number)
                        { step in
                            CookingStepCard(step: step)
                        }
                    }
                }
            }
            .padding(.top, 20)
        }
    }
}

#Preview {
    IngredientsAndCookingStepsSheet(
        servings: 1,
        ingredients: recipeDetailsMockData.extendedIngredients,
        cookingSteps: recipeDetailsMockData.cookingSteps
    )
}
