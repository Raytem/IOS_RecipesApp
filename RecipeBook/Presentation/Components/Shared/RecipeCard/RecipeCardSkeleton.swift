//
//  RecipeCardSkeleton.swift
//  RecipeBook
//
//  Created by Daniil on 10.01.25.
//

import SwiftUI

struct RecipeCardSkeleton: View {
    @Binding var viewType: RecipeCardViewType
    
    private var isStackVertical: Bool {
        getRecipeCardSettings(for: viewType).isStackVertical
   }
    
    private var imageHeight: CGFloat {
       getRecipeCardSettings(for: viewType).imageHeight
   }
   
    private var imageWidth: CGFloat {
       getRecipeCardSettings(for: viewType).imageWidth
    }

    private var cardHeight: CGFloat {
       getRecipeCardSettings(for: viewType).cardHeight
    }

    private var buttonAlignment: Alignment {
       getRecipeCardSettings(for: viewType).buttonAlignment
    }
    
    init(
        viewType: Binding<RecipeCardViewType> = .constant(.grid)
    ) {
        self._viewType = viewType
    }
    
    var body: some View {
        DynamicStack(
            isVertical: isStackVertical,
            alignment: .leading,
            spacing: 0
        ) {
            // Image block
            Color(.backgroundLayer2)
            .frame(width: imageWidth, height: imageHeight)
            .cornerRadius(20)
            
            // Card info
            VStack(alignment: .leading, spacing: 0) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("_______________________________").redacted(reason: .placeholder)
                        .overlay(Rectangle().foregroundColor(.backgroundLayer2))
                    Text("___________________________").redacted(reason: .placeholder)
                        .overlay(Rectangle().foregroundColor(.backgroundLayer2))
                    Text("______________").redacted(reason: .placeholder)
                        .overlay(Rectangle().foregroundColor(.backgroundLayer2))
                }
                Spacer()
                RoundedRectangle(cornerRadius: 10)
                    .fill(.backgroundLayer2)
                    .frame(maxWidth: 180, maxHeight: 45)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(5)
        }
        .frame(height: cardHeight)
        .background(.backgroundMain)
        .cornerRadius(15)
    }
}

#Preview {
    RecipeCardSkeleton(
        viewType: .constant(.grid)
    )
}
