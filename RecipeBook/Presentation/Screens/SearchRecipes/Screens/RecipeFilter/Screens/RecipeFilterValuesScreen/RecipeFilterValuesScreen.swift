//
//  RecipeFilterValuesScreen.swift
//  RecipeBook
//
//  Created by Daniil on 12.01.25.
//

import SwiftUI


struct RecipeFilterValuesScreen<Item: DisplayNamable>: View {
    @Environment(\.dismiss) var dismiss
    
    @State var viewModel: RecipeFilterValuesScreenViewModel<Item>
    @Binding var selectedItems: Set<Item>
       
    var body: some View {
       NavigationStack {
           ZStack {
               List(viewModel.searchResults, id: \.self) { item in
                   HStack {
                       Checkmark(
                            isActive: viewModel.temporarySelectedItems.contains(item),
                            activeColor: .primary50,
                            disabledColor: .primary50
                       )
                       
                       Text(item.displayName)
                   }
                   .frame(maxWidth: .infinity, alignment: .leading)
                   .contentShape(Rectangle())
                   .listRowBackground(Color(.backgroundMain))
                   .onTapGesture {
                       viewModel.toggleSelection(of: item)
                   }
               }
               .safeAreaInset(edge: .bottom) {
                   Color.clear.frame(height: 70)
               }
               .listStyle(.plain)
               .scrollContentBackground(.hidden)
               .background(.backgroundMain)
               
               VStack {
                   Spacer()
                   CustomButton(
                       title: "Apply",
                       color: .primary,
                       fullWidth: true,
                       withShadow: true,
                       disabled: viewModel.isApplyButtonDisabled,
                       action: handleApplyButtonClick
                   )
                   .padding(15)
               }
           }
           
           .searchable(
                text: $viewModel.searchTerm,
                placement: .navigationBarDrawer(displayMode: .always)
           )
           
           .toolbar {
               ToolbarItem(placement: .topBarTrailing) {
                   Button(action: viewModel.selectAllOrReset) {
                       Text(viewModel.selectAllOrResetButtonText)
                   }
               }
           }
           
           .applyCustomNavigationBarTitle(viewModel.navigationTitleText)
           .applyDefaultTopBarStyle()
       }
       .accentColor(.toolbarItemAccent)
        
       .onAppear {
           viewModel.temporarySelectedItems = selectedItems
       }
    }

    func handleApplyButtonClick() {
        dismiss()
        viewModel.handleApply(
            selectedItemsBinding: &selectedItems
        )
    }

}

#Preview {
    RecipeFilterValuesScreen(
        viewModel: RecipeFilterValuesScreenViewModel(
            navigationTitle: "Cuisine",
            allItems: Cuisine.allCases
        ),
        selectedItems: .constant(Set([Cuisine.african, Cuisine.american]))
    )
}
