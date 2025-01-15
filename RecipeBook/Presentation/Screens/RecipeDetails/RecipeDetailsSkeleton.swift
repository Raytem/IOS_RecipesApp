//
//  RecipeDetailsSkeleton.swift
//  RecipeBook
//
//  Created by Daniil on 15.01.25.
//

import SwiftUI

struct RecipeDetailsSkeleton: View {
    var recipeDetailsPreview: RecipeDetailsPreview? = nil
    
    var body: some View {
        ZStack {
            Color(.backgroundMain)
            
            VStack(spacing: 10) {
                ImageSection(
                    title: recipeDetailsPreview?.title ?? "",
                    image: recipeDetailsPreview?.image
                )
                
                HStack(spacing: 10) {
                    ForEach(1...2, id: \.self) { _ in
                        RecipeDetailsSection {
                            Rectangle()
                                .fill(Color(.clear))
                                .frame(height: 50)
                        } topOutOfPaddingContent: {}
                    }
                }
                
                ForEach(1...2, id: \.self) { _ in
                    RecipeDetailsSection {
                        Rectangle()
                            .fill(Color(.clear))
                            .frame(height: 70)
                    } topOutOfPaddingContent: {}
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    RecipeDetailsSkeleton()
}
