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
        let mappedDiets = Diet.allCases.filter {
            resp.diets.contains($0.rawValue) ? true : false
        }
        
        return RecipeModel(
            id: resp.id,
            title: resp.title,
            image: URL(string: resp.image),
            readyInMinutes: resp.readyInMinutes,
            aggregateLikes: resp.aggregateLikes,
            diets: mappedDiets
        )
    }
}
