//
//  RecipeFilterValuesScreenViewModel.swift
//  RecipeBook
//
//  Created by Daniil on 12.01.25.
//

import Foundation
import SwiftUI

@Observable
class RecipeFilterValuesScreenViewModel<Item: DisplayNamable> {
    var temporarySelectedItems: Set<Item>
    var searchTerm: String
    
    let allItems: [Item]
    let navigationTitle: String
    
    init(
        navigationTitle: String,
        allItems: [Item]
    ) {
        self.temporarySelectedItems = []
        self.searchTerm = ""
        self.allItems = allItems
        self.navigationTitle = navigationTitle
    }
    
    var selectAllOrRestButtonMode: SelectAllOrRestButtonMode {
        temporarySelectedItems.count == allItems.count
        ? .reset
        : .selectAll
    }
    
    var navigationTitleText: String {
        if temporarySelectedItems.isEmpty {
            return navigationTitle
        }
        return String(localized: "Selected: \(temporarySelectedItems.count)")
    }
    
    
    var selectAllOrResetButtonText: LocalizedStringKey {
        let value = switch selectAllOrRestButtonMode {
        case .selectAll: LocalizedStringKey("Select All")
        case .reset: LocalizedStringKey("Reset")
        }
        return value
    }
    
    var isApplyButtonDisabled: Bool {
        temporarySelectedItems.isEmpty
        ? true
        : false
    }
    
    var searchResults: [Item] {
        var items: [Item]
        
        if searchTerm.isEmpty {
            items = allItems
        } else {
            items = allItems.filter {
                $0.displayName
                    .lowercased()
                    .contains(searchTerm.lowercased())
            }
        }
        return items
            .sorted(by: { $0.displayName < $1.displayName })
    }
    
    func selectAllOrReset() {
        switch selectAllOrRestButtonMode {
        case .reset:
            temporarySelectedItems.removeAll()
        case .selectAll:
            temporarySelectedItems = Set(allItems)
        }
    }
    
    func handleApply(selectedItemsBinding: inout Set<Item>) {
        selectedItemsBinding = temporarySelectedItems
    }
   
    func toggleSelection(of item: Item) {
        withAnimation(.spring(duration: 0.15)) {
            if temporarySelectedItems.contains(item) {
                temporarySelectedItems.remove(item)
            } else {
                temporarySelectedItems.insert(item)
            }
        }
    }
}
