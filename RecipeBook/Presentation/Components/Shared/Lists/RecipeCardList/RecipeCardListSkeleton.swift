//
//  RecipeCardListSkeleton.swift
//  RecipeBook
//
//  Created by Daniil on 10.01.25.
//

import SwiftUI

struct RecipeCardListSkeleton: View {
    @Binding var viewType: RecipeCardViewType
    
    init(
        viewType: Binding<RecipeCardViewType> = .constant(.grid)
    ) {
        self._viewType = viewType
    }
    
    var body: some View {
        LazyVGrid(
            columns: Array(
                repeating: GridItem(.flexible(), spacing: 2),
                count: viewType == .grid ? 2 : 1
            ),
            spacing: 10
        ) {
            ForEach(1...6, id: \.self) { _ in
                RecipeCardSkeleton(viewType: $viewType)
            }
        }.padding()
    }
}

#Preview {
    RecipeCardListSkeleton()
}
