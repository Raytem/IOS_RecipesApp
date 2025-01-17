//
//  RecipeFilterScreen.swift
//  RecipeBook
//
//  Created by Daniil on 11.01.25.
//

import SwiftUI

struct RecipeFilterScreen: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var maxReadyTimeText: String = ""
    
    @State var temporaryFilters = SearchRecipesFilter()
    @Binding var filters: SearchRecipesFilter
    @Binding var cardViewType: RecipeCardViewType
    
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
                        Picker("View mode", selection: $cardViewType) {
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
                        VStack(alignment: .leading) {
                            Text("Max ready time, min")
                            TextField("∞", text: $maxReadyTimeText)
                                .padding(10)
                                .background(.backgroundLayer2)
                                .cornerRadius(10)
                                .keyboardType(.numberPad)
                        }
                        RecipeFilterFormNavigationLink(
                            title: "Cusine",
                            allItems: Cuisine.allCases,
                            selectedItems: $temporaryFilters.cuisines
                        )
                        RecipeFilterFormNavigationLink(
                            title: "Diet",
                            allItems: Diet.allCases,
                            selectedItems: $temporaryFilters.diets
                        )
                        RecipeFilterFormNavigationLink(
                            title: "Meal types",
                            allItems: MealType.allCases,
                            selectedItems: $temporaryFilters.mealTypes
                        )
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
                
                ToolbarItemGroup(placement: .keyboard) {
                    HStack() {
                        Spacer()
                        Button("Done") {
                            hideKeyboard()
                        }
                        .foregroundStyle(Color(.primary50))
                    }
                }
            }
            
            .applyCustomNavigationBarTitle("Filters")
            .applyDefaultTopBarStyle()
        }
        .accentColor(.toolbarItemAccent)
        
        .onAppear {
            temporaryFilters = filters
            if let maxReadyTime = filters.maxReadyTime {
                maxReadyTimeText = String(maxReadyTime)
            }
        }
        
        .onChange(of: maxReadyTimeText) {
            maxReadyTimeText = maxReadyTimeText.filter { $0.isNumber }
        }
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
        temporaryFilters.maxReadyTime = maxReadyTimeText.isEmpty ? nil : Int(maxReadyTimeText)
        filters = temporaryFilters
        
        dismiss()
        handleFiltersApplly()
    }
    
    private func resetAllFilters() {
        temporaryFilters = SearchRecipesFilter()
        maxReadyTimeText = ""
    }
    
}

#Preview {
    RecipeFilterScreen(
        filters: .constant(SearchRecipesFilter()),
        cardViewType: .constant(.grid),
        handleFiltersApplly: { print("handleFiltersApplly") }
    )
}
