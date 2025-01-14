//
//  RecipeMapper.swift
//  RecipeBook
//
//  Created by Daniil on 7.01.25.
//

import SwiftUI

struct RecipeMapper {
    static func mapFromComplexSearchResponse(
        _ resp: ComplexSearchRecipeResponse
    ) -> RecipeModel {
        RecipeModel(
            id: resp.id,
            title: resp.title,
            image: URL(string: resp.image),
            readyInMinutes: resp.readyInMinutes,
            aggregateLikes: resp.aggregateLikes,
            diets: resp.diets
        )
    }
}
