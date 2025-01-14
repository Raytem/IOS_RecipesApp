//
//  PaginatedDataApiResponse.swift
//  RecipeBook
//
//  Created by Daniil on 14.01.25.
//

import Foundation

struct PaginatedDataResponse<Result: Decodable>: Decodable {
    var results: [Result]
    var offset: Int
    var number: Int
    var totalResults: Int
}

// offset = 2, number = 2, total
