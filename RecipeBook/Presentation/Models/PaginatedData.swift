//
//  Pagination.swift
//  RecipeBook
//
//  Created by Daniil on 14.01.25.
//

import Foundation

struct PaginatedDataModel<Item: Any> {
    let data: [Item]
    let currentPage: Int
    let lastPage: Int
    let totalResults: Int
    let itemsOnPage: Int
    
    func mapData<U>(_ transform: (Item) -> U) -> PaginatedDataModel<U> {
        return PaginatedDataModel<U>(
            data: self.data.map(transform),
            currentPage: self.currentPage,
            lastPage: self.lastPage,
            totalResults: self.totalResults,
            itemsOnPage: self.itemsOnPage
        )
    }
}
