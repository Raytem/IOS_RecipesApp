//
//  ImageCardSection.swift
//  RecipeBook
//
//  Created by Daniil on 15.01.25.
//

import SwiftUI

struct ImageSection: View {
    var title: String
    var image: URL?
    
    var body: some View {
        RecipeDetailsSection {
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
        } topOutOfPaddingContent: {
            CustomAsyncImage(
                url: image,
                background: {AnyView(Color(uiColor: .backgroundLayer1))}
            )
            .frame(height: 350)
        }
    }
}

#Preview {
    ImageSection(
        title: "Title",
        image: recipeDetailsMockData.image
    )
}
