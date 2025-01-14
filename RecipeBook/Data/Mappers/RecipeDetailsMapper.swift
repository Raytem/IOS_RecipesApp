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
        RecipeDetailsModel(
            id: resp.id,
            title: resp.title,
            image: URL(string: resp.image),
            readyInMinutes: resp.readyInMinutes,
            aggregateLikes: resp.aggregateLikes,
            diets: resp.diets,
            cuisines: resp.cuisines,
            dishTypes: resp.dishTypes,
            summary: resp.summary,
            healthScore: resp.healthScore,
            extendedIngredients: resp.extendedIngredients.map({
                RecipeDetailsModel.ExtendedIngredient(
                    id: $0.id,
                    name: $0.nameClean,
                    image:
                        URL(string: "\(AppConfig.config.recipeApi.ingredientsImgServerBaseUrl)/\($0.image)"),
                    consistency: $0.consistency,
                    amount: $0.amount,
                    unit: $0.unit
                )
            })
        )
    }
}
