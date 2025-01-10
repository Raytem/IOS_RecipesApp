//
//  RecipeCardSkeleton.swift
//  RecipeBook
//
//  Created by Daniil on 10.01.25.
//

import SwiftUI

struct RecipeCardSkeleton: View {
    @Binding var viewType: RecipeCardViewType
    
    @State private var imageHeight: CGFloat = 0
    @State private var imageWidth: CGFloat = 0
    @State private var cardHeight: CGFloat = 0
    @State private var buttonAlignment: Alignment = .center
    @State private var isStackVertical: Bool = true
    
    init(
        viewType: Binding<RecipeCardViewType> = .constant(.grid)
    ) {
        self._viewType = viewType
    }
    
    var body: some View {
        DynamicStack(
            isVertical: $isStackVertical,
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
        .padding(6)
        .frame(height: cardHeight)
        .background(.backgroundMain)
        .cornerRadius(15)
        
        .onAppear() {
            updateSettings(for: viewType)
        }
        .onChange(of: viewType) {
            updateSettings(for: viewType)
        }
    }
    
    private func updateSettings(for viewType: RecipeCardViewType) {
        let settings = getRecipeCardSettings(for: viewType)
        imageHeight = settings.imageHeight
        imageWidth = settings.imageWidth
        cardHeight = settings.cardHeight
        buttonAlignment = settings.buttonAlignment
        isStackVertical = settings.isStackVertical
    }
}

#Preview {
    RecipeCardSkeleton()
}
