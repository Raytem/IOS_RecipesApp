//
//  AboutRecipeSection.swift
//  RecipeBook
//
//  Created by Daniil on 15.01.25.
//

import SwiftUI

struct AboutRecipeSection: View {
    var recipeDetailsModel: RecipeDetailsModel
    
    @State private var buttonHeight: CGFloat = 0
    
    var body: some View {
        RecipeDetailsSection(title: "About recipe") {
            ZStack {
                Text(recipeDetailsModel.summary)
                    .lineLimit(2)
                    .foregroundStyle(.gray)
                
                VStack(alignment: .trailing) {
                    Spacer()
                    HStack {
                        Spacer()
                        
                        GradientOverlayContainer(
                            gradientSide: .left,
                            color: .backgroundLayer1
                        ) {
                            CustomButton(
                                title: "more info",
                                color: .primary,
                                size: .small,
                                variant: .text,
                                endIcon: "chevron.right",
                                withPaddings: false,
                                action: {}
                            )
                        }
                    }
                }
                .allowsHitTesting(false)

            }
        } topOutOfPaddingContent: {}
    }
}

#Preview {
    AboutRecipeSection(
        recipeDetailsModel: recipeDetailsMockData
    )
}
