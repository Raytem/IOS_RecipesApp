//
//  AppConfig.swift
//  RecipeBook
//
//  Created by Daniil on 14.01.25.
//

import Foundation


final class AppConfig {
    static var config: AppConfigType {
        return AppConfigType(
            recipeApi: self.getRecipeApiConfig()
        )
    }
    
    static private func getRecipeApiConfig() -> AppConfigType.RecipeApiConfig {
        return AppConfigType.RecipeApiConfig(
            baseUrl: ProcessInfo.processInfo.environment["RECIPE_API_BASE_URL"] ?? "",
            apiKey: ProcessInfo.processInfo.environment["RECIPE_API_KEY"] ?? "",
            ingredientsImgServerBaseUrl: ProcessInfo.processInfo.environment["RECIPE_API_INGREDIENTS_IMG_SERVER_BASE_URL"] ?? ""
        )
    }
    
}
