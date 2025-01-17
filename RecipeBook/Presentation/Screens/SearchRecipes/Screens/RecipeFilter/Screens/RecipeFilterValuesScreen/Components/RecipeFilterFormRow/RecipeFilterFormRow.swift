//
//  RecipeFilterFormRow.swift
//  RecipeBook
//
//  Created by Daniil on 11.01.25.
//

import SwiftUI

struct RecipeFilterFormRow<Item: DisplayNamable>: View {
    var title: LocalizedStringKey
    var selectedValues: [Item]
    var handleRest: () -> Void = {}
    
    init(
        title: LocalizedStringKey,
        selectedValues: [Item] = [],
        handleRest: @escaping () -> Void
    ) {
        self.title = title
        self.selectedValues = selectedValues
        self.handleRest = handleRest
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .lineLimit(1)
                if !selectedValues.isEmpty {
                    Text(getSelectedValuesString())
                        .font(.footnote)
                        .foregroundStyle(.gray)
                        .lineLimit(1)
                }
            }
            Spacer()
            
             if !selectedValues.isEmpty {
                 CustomButton(
                    title: "Reset",
                    color: .primary,
                    size: .small,
                    variant: .text,
                    fontWeight: .regular,
                    withPaddings: false,
                    action: handleRest
                )
             }
        }
    }
    
    func getSelectedValuesString() -> String {
        return selectedValues
            .map { $0.displayName }
            .sorted(by: <)
            .joined(separator: "; ")
    }
}

#Preview {
    RecipeFilterFormRow(
        title: "Title",
        selectedValues: Cuisine.allCases,
        handleRest: { print("handleRest") }
    )
}
