//
//  RecipeMapper.swift
//  RecipeBook
//
//  Created by Daniil on 7.01.25.
//

import SwiftUI

struct RecipeMapper {
    
    static func mapFromDto(_ dto: RecipeDto) -> RecipeModel {
        return RecipeModel(
            id: dto.id,
            title: dto.title,
            image: URL(string: dto.sourceUrl),
            readyInMinutes: dto.readyInMinutes,
            aggregateLikes: dto.aggregateLikes,
            diets: dto.diets
        )
    }
}
