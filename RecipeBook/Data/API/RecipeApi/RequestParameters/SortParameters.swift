//
//  SortParameters.swift
//  RecipeBook
//
//  Created by Daniil on 14.01.25.
//

struct SortParameters<SortBy: RawRepresentable> where SortBy.RawValue == String {
    var sort: SortBy? = nil
    var sortDirection: SortDirection? = nil
}
