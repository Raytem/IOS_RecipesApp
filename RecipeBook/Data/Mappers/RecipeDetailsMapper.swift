//
//  RecipeDetailsMapper.swift
//  RecipeBook
//
//  Created by Daniil on 7.01.25.
//

import Foundation
import SwiftUI


struct RecipeDetailsMapper {
    static func mapFormDetailsResponse(
        _ resp: RecipeDetailsResponse
    ) -> RecipeDetailsModel {
        let mappedDiets = Diet.allCases.filter {
            resp.diets.contains($0.rawValue)
        }
        let mappedMealTypes = MealType.allCases.filter {
            resp.dishTypes.contains($0.rawValue)
        }
        let mappedCuisines = Cuisine.allCases.filter {
            resp.cuisines.contains($0.rawValue)
        }
        
        return RecipeDetailsModel(
            id: resp.id,
            title: resp.title,
            image: URL(string: resp.image),
            readyInMinutes: resp.readyInMinutes,
            aggregateLikes: resp.aggregateLikes,
            diets: mappedDiets,
            cuisines: mappedCuisines,
            dishTypes: mappedMealTypes,
            summary: resp.summary,
            healthScore: resp.healthScore,
            servings: resp.servings,
            sourceUrl: resp.spoonacularSourceUrl,
            nutrition: RecipeDetailsModel.Nutrition(
                nutrients: resp.nutrition.nutrients.map {
                    .init(
                        name: $0.name,
                        amount: $0.amount,
                        unit: $0.unit
                    )
                },
                weightPerServing: .init(
                    amount: resp.nutrition.weightPerServing.amount,
                    unit: resp.nutrition.weightPerServing.unit
                )
            ),
            extendedIngredients: resp.extendedIngredients.map({
                .init(
                    id: $0.id,
                    name: $0.nameClean,
                    image:
                        URL(string: "\(AppConfig.config.recipeApi.ingredientsImgServerBaseUrl)/\($0.image)"),
                    consistency: $0.consistency,
                    amount: $0.amount,
                    unit: $0.unit
                )
            }),
            cookingSteps: !resp.analyzedInstructions.isEmpty
                ? resp.analyzedInstructions[0].steps.map {
                    .init(
                        number: $0.number,
                        desctipion: $0.step
                    )
                }
                : []
        )
    }
}
