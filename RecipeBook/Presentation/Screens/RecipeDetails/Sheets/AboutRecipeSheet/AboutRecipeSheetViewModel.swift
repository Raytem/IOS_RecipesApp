//
//  AboutRecipeSheetViewModel.swift
//  RecipeBook
//
//  Created by Daniil on 15.01.25.
//

import Foundation
import SwiftUI

@Observable
class AboutRecipeSheetViewModel {
    var recipeDetailsModel: RecipeDetailsModel
    
    init(
        recipeDetailsModel: RecipeDetailsModel
    ) {
        self.recipeDetailsModel = recipeDetailsModel
    }
    
    func getKeyValueTablesFromDetails() -> [KeyValueTableModel] {
        [
            .init(
                id: 1,
                title: "Main info",
                rows: [
                    (key: "Cuisines", value: recipeDetailsModel.cuisines.map { $0.displayName }.joined(separator: ", ").lowercased() ),
                    (key: "Meal types", value: recipeDetailsModel.dishTypes.map { $0.displayName }.joined(separator: ", ").lowercased() ),
                    (key: "Diets", value: recipeDetailsModel.diets.map { $0.displayName }.joined(separator: ", ").lowercased() ),
                    (key: "Weight per serving", value: "\(recipeDetailsModel.nutrition.weightPerServing.amount) \(recipeDetailsModel.nutrition.weightPerServing.unit)")
                ]
            ),
            .init(
                id: 2,
                title: "Nutrients",
                rows: recipeDetailsModel.nutrition.nutrients.map {
                    (key: "\($0.name)", value: "\(NumberUtil.getFormattedNumber($0.amount)) \($0.unit)")
                }
            )
        ]
    }
}
