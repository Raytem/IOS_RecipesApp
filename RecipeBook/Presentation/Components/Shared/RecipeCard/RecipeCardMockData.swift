//
//  RecipeCardMockData.swift
//  RecipeBook
//
//  Created by Daniil on 10.01.25.
//

import Foundation

var recipeCardMockData: [RecipeModel] = [
    .init(
        id: 1,
        title: "Red Lentil Soup with ",
        image: URL(string: "https://img.spoonacular.com/recipes/715415-312x231.jpg"),
        readyInMinutes: 78,
        aggregateLikes: 1340,
        diets: [.vegan, .glutenFree]
    ),
    .init(
        id: 2,
        title: "Red Lentil Soup with Chicken and Turnips and something else",
        image: URL(string: "https://img.povar.ru/mobile/e6/cf/11/c8/krevetki_v_slivochno-chesnochnom_souse-644129.JPG"),
        readyInMinutes: 20,
        aggregateLikes: 1340,
        diets: [.vegan, .glutenFree]
    ),
    .init(
        id: 3,
        title: "Red Lentil Soup with Chicken and Turnips",
        image: URL(string: "https://www.steakhome.ru/upload/iblock/631/631bc2e3ff55546997f496395aae39e0.jpg"),
        readyInMinutes: 30,
        aggregateLikes: 1340,
        diets: [.vegan, .glutenFree]
    ),
    .init(
        id: 4,
        title: "Red Lentil Soup with Chicken and Turnips",
        image: URL(string: "https://img.iamcook.ru/2022/upl/recipes/cat/u-9006fa19d5ee6fd1100570e52dc85a9e.jpg"),
        readyInMinutes: 45,
        aggregateLikes: 1340,
        diets: [.vegan, .glutenFree]
    ),
    .init(
        id: 5,
        title: "Red Lentil Soup with ",
        image: URL(string: "https://img.spoonacular.com/recipes/715415-312x231.jpg"),
        readyInMinutes: 45,
        aggregateLikes: 1340,
        diets: [.vegan, .glutenFree]
    ),
    .init(
        id: 6,
        title: "Red Lentil Soup with Chicken and Turnips and something else",
        image: URL(string: "https://img.povar.ru/mobile/e6/cf/11/c8/krevetki_v_slivochno-chesnochnom_souse-644129.JPG"),
        readyInMinutes: 20,
        aggregateLikes: 1340,
        diets: [.vegan, .glutenFree]
    ),
    .init(
        id: 7,
        title: "Red Lentil Soup with Chicken and Turnips",
        image: URL(string: "https://www.steakhome.ru/upload/iblock/631/631bc2e3ff55546997f496395aae39e0.jpg"),
        readyInMinutes: 30,
        aggregateLikes: 1340,
        diets: [.vegan, .glutenFree]
    ),
    .init(
        id: 8,
        title: "Red Lentil Soup with Chicken and Turnips",
        image: URL(string: "https://img.iamcook.ru/2022/upl/recipes/cat/u-9006fa19d5ee6fd1100570e52dc85a9e.jpg"),
        readyInMinutes: 45,
        aggregateLikes: 1340,
        diets: [.vegan, .glutenFree]
    ),
    .init(
        id: 9,
        title: "Red Lentil Soup with ",
        image: URL(string: "https://img.spoonacular.com/recipes/715415-312x231.jpg"),
        readyInMinutes: 45,
        aggregateLikes: 1340,
        diets: [.vegan, .glutenFree]
    ),
    .init(
        id: 10,
        title: "Red Lentil Soup with Chicken and Turnips and something else",
        image: URL(string: "https://img.povar.ru/mobile/e6/cf/11/c8/krevetki_v_slivochno-chesnochnom_souse-644129.JPG"),
        readyInMinutes: 20,
        aggregateLikes: 1340,
        diets: [.vegan, .glutenFree]
    ),
    .init(
        id: 11,
        title: "Red Lentil Soup with Chicken and Turnips",
        image: URL(string: "https://www.steakhome.ru/upload/iblock/631/631bc2e3ff55546997f496395aae39e0.jpg"),
        readyInMinutes: 30,
        aggregateLikes: 1340,
        diets: [.vegan, .glutenFree]
    ),
    .init(
        id: 12,
        title: "Red Lentil Soup with Chicken and Turnips",
        image: URL(string: "https://img.iamcook.ru/2022/upl/recipes/cat/u-9006fa19d5ee6fd1100570e52dc85a9e.jpg"),
        readyInMinutes: 45,
        aggregateLikes: 1340,
        diets: [.vegan, .glutenFree]
    )
]

func getNewRicipeMockData() -> [RecipeModel] {
    return recipeCardMockData.map {
        var recipe = $0
        recipe.id = Int.random(in: 1...100000)
        return recipe
    }
}
