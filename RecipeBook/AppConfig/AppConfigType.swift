//
//  AppConfigType.swift
//  RecipeBook
//
//  Created by Daniil on 14.01.25.
//

struct AppConfigType {
    struct RecipeApiConfig {
        let baseUrl: String
        let apiKey: String
        let ingredientsImgServerBaseUrl: String
    }
        
    let recipeApi: RecipeApiConfig
}
