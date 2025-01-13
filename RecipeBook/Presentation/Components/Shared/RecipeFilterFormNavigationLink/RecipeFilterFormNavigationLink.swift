//
//  RecipeFilterFormNvigationLink.swift
//  RecipeBook
//
//  Created by Daniil on 13.01.25.
//

import SwiftUI

struct RecipeFilterFormNavigationLink<Item: DisplayNamable>: View {
    var title: LocalizedStringKey
    var allItems: [Item]
    @Binding var selectedItems: Set<Item>

    var body: some View {
        NavigationLink {
            RecipeFilterValuesScreen(
                viewModel: RecipeFilterValuesScreenViewModel(
                    navigationTitle: title,
                    allItems: allItems
                ),
                selectedItems: $selectedItems
            )
        } label: {
            RecipeFilterFormRow(
                title: title,
                selectedValues: Array(selectedItems),
                handleRest: { selectedItems.removeAll() }
            )
        }
    }
}

#Preview {
    RecipeFilterFormNavigationLink(
        title: "Кухня",
        allItems: Cuisine.allCases,
        selectedItems: .constant(Set())
    )
}
