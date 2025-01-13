//
//  ApplyCustomNavigationBarTitleExtension.swift
//  RecipeBook
//
//  Created by Daniil on 12.01.25.
//

import SwiftUI

extension View {
    
    func applyCustomNavigationBarTitle(_ title: LocalizedStringKey) -> some View {
        self
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                }
            }
    }
}
