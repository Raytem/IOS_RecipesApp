//
//  ImageCardSection.swift
//  RecipeBook
//
//  Created by Daniil on 15.01.25.
//

import SwiftUI

struct ImageSection: View {
    var recipeDetailsPreview: RecipeDetailsPreview? = nil
    
    var body: some View {
        RecipeDetailsSection {
            Text(recipeDetailsPreview?.title ?? "")
                .font(.headline)
                .fontWeight(.semibold)
        } topOutOfPaddingContent: {
            CustomAsyncImage(
                url: recipeDetailsPreview?.image,
                background: {AnyView(Color(uiColor: .backgroundLayer1))}
            )
            .frame(height: 350)
        }
    }
}

#Preview {
    ImageSection(
        recipeDetailsPreview: RecipeDetailsPreview(
            title: recipeDetailsMockData.title,
            image: recipeDetailsMockData.image
        )
    )
}
