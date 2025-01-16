//
//  CookingStepCard.swift
//  RecipeBook
//
//  Created by Daniil on 16.01.25.
//

import SwiftUI

struct CookingStepCard: View {
    var step: RecipeDetailsModel.CookingStep
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Step \(step.number)")
                .font(.headline)
                .multilineTextAlignment(.leading)

            Text(step.desctipion)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(.backgroundLayer2)
        .cornerRadius(15)
    }
}

#Preview {
    CookingStepCard(
        step: recipeDetailsMockData.cookingSteps[0]
    )
}
