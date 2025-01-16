//
//  RecipeDetailsMockData.swift
//  RecipeBook
//
//  Created by Daniil on 15.01.25.
//

import SwiftUI


let recipeDetailsMockData = RecipeDetailsModel(
    id: 716429,
    title: "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs",
    image: URL(string: "https://img.spoonacular.com/recipes/775585-556x370.jpg"),
    readyInMinutes: 70,
    aggregateLikes: 209,
    diets: [.dairyFree],
    cuisines: [.asian],
    dishTypes: [.lunch, .mainCourse, .mainDish, .dinner],
    summary: "You can never have too many main course recipes, so give Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs a try. One serving contains 543 calories, 17g of protein, and 16g of fat. For $1.57 per serving, this recipe covers 22% of your daily requirements of vitamins and minerals. This recipe serves 2. A mixture of butter, white wine, pasta, and a handful of other ingredients are all it takes to make this recipe so yummy. 209 people have tried and liked this recipe. It is brought to you by fullbellysisters.blogspot.com. From preparation to the plate, this recipe takes approximately 45 minutes. Taking all factors into account, this recipe earns a spoonacular score of 83%, which is tremendous. If you like this recipe, take a look at these similar recipes: Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs, Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs, and Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs.",
    healthScore: 19,
    servings: 2,
    sourceUrl: "https://spoonacular.com/crockpot-refried-beans-775585",
    nutrition: RecipeDetailsModel.Nutrition(
        nutrients: [
            .init(
                name: "Calories",
                amount: 10,
                unit: "kkal"
            ),
            .init(
                name: "Shugar",
                amount: 20,
                unit: "g"
            )
        ],
        weightPerServing: .init(
            amount: 230,
            unit: "g"
        )
    ),
    extendedIngredients: [
        .init(
            id: 1001,
            name: "butter",
            image: URL(string: "\(AppConfig.config.recipeApi.ingredientsImgServerBaseUrl)/butter-sliced.jpg"),
            consistency: "solid",
            amount: 1.0,
            unit: "tbsp"
        ),
        .init(
            id: 10011135,
            name: "cauliflower florets",
            image: URL(string: "\(AppConfig.config.recipeApi.ingredientsImgServerBaseUrl)/cauliflower.jpg"),
            consistency: "solid",
            amount: 2.0,
            unit: "cups"
        ),
        .init(
            id: 1041009,
            name: "cheese",
            image: URL(string: "\(AppConfig.config.recipeApi.ingredientsImgServerBaseUrl)/cheddar-cheese.png"),
            consistency: "solid",
            amount: 2.0,
            unit: "tbsp"
        ),
        .init(
            id: 1034053,
            name: "extra virgin olive oil",
            image: URL(string: "\(AppConfig.config.recipeApi.ingredientsImgServerBaseUrl)/olive-oil.jpg"),
            consistency: "liquid",
            amount: 1.0,
            unit: "tbsp"
        ),
        .init(
            id: 11215,
            name: "garlic",
            image: URL(string: "\(AppConfig.config.recipeApi.ingredientsImgServerBaseUrl)/garlic.jpg"),
            consistency: "solid",
            amount: 5.0,
            unit: "cloves"
        ),
        .init(
            id: 20420,
            name: "pasta",
            image: URL(string: "\(AppConfig.config.recipeApi.ingredientsImgServerBaseUrl)/fusilli.jpg"),
            consistency: "solid",
            amount: 6.0,
            unit: "ounces"
        ),
        .init(
            id: 1032009,
            name: "red pepper flakes",
            image: URL(string: "\(AppConfig.config.recipeApi.ingredientsImgServerBaseUrl)/red-pepper-flakes.jpg"),
            consistency: "solid",
            amount: 2.0,
            unit: "pinches"
        ),
        .init(
            id: 1102047,
            name: "salt and pepper",
            image: URL(string: "\(AppConfig.config.recipeApi.ingredientsImgServerBaseUrl)/salt-and-pepper.jpg"),
            consistency: "solid",
            amount: 2.0,
            unit: "servings"
        ),
        .init(
            id: 11291,
            name: "scallions",
            image: URL(string: "\(AppConfig.config.recipeApi.ingredientsImgServerBaseUrl)/spring-onions.jpg"),
            consistency: "solid",
            amount: 3.0,
            unit: ""
        ),
        .init(
            id: 14106,
            name: "white wine",
            image: URL(string: "\(AppConfig.config.recipeApi.ingredientsImgServerBaseUrl)/white-wine.jpg"),
            consistency: "liquid",
            amount: 2.0,
            unit: "tbsp"
        ),
        .init(
            id: 99025,
            name: "whole wheat bread crumbs",
            image: URL(string: "\(AppConfig.config.recipeApi.ingredientsImgServerBaseUrl)/breadcrumbs.jpg"),
            consistency: "solid",
            amount: 0.25,
            unit: "cup"
        )
    ],
    cookingSteps: [
        .init(number: 1, desctipion: "Do something jksljf ksdjflsd fj"),
        .init(number: 2, desctipion: "D sdf sdf  sdfo something jksljf  sdfsd fsksdjflsd fj"),
        .init(number: 3, desctipion: "Do something jksljf ksdjflsd fj"),
        .init(number: 4, desctipion: "Do something jksljf ksdjfl sd fsd  sdfsd fj"),
        .init(number: 5, desctipion: "Do something jksljf ksdjflsdksdj lsjd kjsdl fjklsdj flksd fsd f fj")
    ]
)
