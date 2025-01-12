//
//  RecipeFilterScreen.swift
//  RecipeBook
//
//  Created by Daniil on 11.01.25.
//

import SwiftUI

struct RecipeFilterScreen: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var filters: SearchRecipesFilter
    var handleFiltersApplly: () -> Void
    
    var body: some View {
        NavigationStack {
            ZStack {
                Form {
                    Section(
                        header: Text("View mode")
                            .textCase(.none)
                            .font(.headline)
                    ) {
                        Picker("View mode", selection: $filters.cardViewType) {
                            ForEach(RecipeCardViewType.allCases, id: \.self) { type in
                                Image(systemName: getViewModeImageSystemName(for: type))
                            }
                        }
                        .pickerStyle(.segmented)
                        .foregroundColor(.primary40)
                    }
                    .listRowBackground(Color(.backgroundLayer1))
                    
                    Section(
                        header: Text("Filters")
                                    .textCase(.none)
                                    .font(.headline)
                    ) {
                        NavigationLink {
                            RecipeFilterValuesScreen(
                                viewModel: RecipeFilterValuesScreenViewModel(
                                    navigationTitle: "Cusine",
                                    allItems: Cuisine.allCases
                                ),
                                selectedItems: $filters.cuisines
                            )
                        } label: {
                            RecipeFilterFormRow(
                                title: "Cusine",
                                selectedValues: Array(filters.cuisines),
                                handleRest: { filters.cuisines.removeAll() }
                            )
                        }
//                        var cuisines: [Cuisine]?
//                        var diets: [Diet]?
//                        var mealTypes: [MealType]?
//                        var maxReadyTime: Double?
                    }
                    .listRowBackground(Color(.backgroundLayer1))
                }
                .safeAreaInset(edge: .bottom) {
                    Color.clear.frame(height: 70)
                }
                .foregroundStyle(Color(.label))
                .background(.backgroundMain)
                .scrollContentBackground(.hidden)
                .listRowBackground(Color(.backgroundMain))

                VStack {
                    Spacer()
                    CustomButton(
                        title: "Apply",
                        color: .primary,
                        fullWidth: true,
                        withShadow: true,
                        action: handleApplyButtonClick
                    )
                    .padding(15)
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: handleCloseButtonClick) {
                        Text("Close")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: resetAllFilters) {
                        Text("Reset all")
                    }
                }
            }
            
            .applyCustomNavigationBarTitle(String(localized: "Filters"))
            .applyDefaultTopBarStyle()
        }
        .accentColor(.toolbarItemAccent)
    }
    
    private func getViewModeImageSystemName(for type: RecipeCardViewType) -> String {
        switch type {
        case .grid: "square.grid.2x2.fill"
        case .list: "list.dash"
        case .single: "square.fill"
        }
    }
    
    private func handleCloseButtonClick() {
        dismiss()
    }
    
    private func handleApplyButtonClick() {
        print("RecipeFilterScreen.handleApplyButtonClick")
        dismiss()
        handleFiltersApplly()
    }
    
    private func resetAllFilters() {
        filters = SearchRecipesFilter(cardViewType: filters.cardViewType)
    }
    
}

#Preview {
    RecipeFilterScreen(
        filters: .constant(SearchRecipesFilter()),
        handleFiltersApplly: { print("handleFiltersApplly") }
    )
}
