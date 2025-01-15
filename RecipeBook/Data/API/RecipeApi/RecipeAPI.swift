//
//  RecipeApi.swift
//  RecipeBook
//
//  Created by Daniil on 14.01.25.
//

import Foundation
import Alamofire


final class RecipeAPI {
    static let shared = RecipeAPI()
    
    private static var baseUrl: String {
        AppConfig.config.recipeApi.baseUrl
    }
    
    private func addApiKeyToParams(_ params: inout [String:String]) {
        params["apiKey"] = AppConfig.config.recipeApi.apiKey
    }
    
    private func addPaginationAndSortToParams<SortBy: RawRepresentable>(
        _ params: inout [String:String],
        _ pagination: PaginationParameters? = nil,
        _ sort: SortParameters<SortBy>? = nil
    ) -> Void {
        if let pagination {
            if let number = pagination.number {
                params["number"] = String(number)
            }
            if let offset = pagination.offset {
                params["offset"] = String(offset)
            }
        }
        if let sort {
            if let sortBy = sort.sort {
                params["sort"] = String(sortBy.rawValue)
            }
            if let sortDirection = sort.sortDirection {
                params["sortDirection"] = String(sortDirection.rawValue)
            }
        }
    }
    
    func complexRecipeSearch(
        parameters: ComplexSearchRequestParameters = ComplexSearchRequestParameters(),
        completion: @escaping (Result<PaginatedDataResponse<ComplexSearchRecipeResponse>, Error>) -> ()
    ) {
        var queryParams: [String:String] = [:]
        
        addApiKeyToParams(&queryParams)
        addPaginationAndSortToParams(&queryParams, parameters.pagination, parameters.sort)
        
        // adding some specific query params to get more data about recipes
        queryParams["addRecipeInformation"] = "true"
        queryParams["addRecipeNutrition"] = "false"
        
        if let query = parameters.query {
            queryParams["query"] = query
        }
        if let cuisines = parameters.cuisines {
            queryParams["cuisine"] = Array(cuisines).map { $0.rawValue }.joined(separator: ",")
        }
        if let diets = parameters.diets {
            queryParams["diet"] = Array(diets).map { $0.rawValue }.joined(separator: ",")
        }
        if let mealTypes = parameters.mealTypes {
            queryParams["type"] = Array(mealTypes).map { $0.rawValue }.joined(separator: ",")
        }
        if let maxReadyTime = parameters.maxReadyTime {
            queryParams["maxReadyTime"] = String(maxReadyTime)
        }
        
        AF.request("\(RecipeAPI.baseUrl)/recipes/complexSearch", parameters: queryParams)
            .response { response in
                do {
                    try NetworkError.mapResponse(response: (data: response.data, response: response.response))
                } catch {
                    completion(.failure(error))
                }
                
                guard let data = response.data else {
                    if let error = response.error {
                        completion(.failure(error))
                    }
                    return
                }
                guard let results = try? JSONDecoder()
                    .decode(PaginatedDataResponse<ComplexSearchRecipeResponse>.self, from: data) else {
                    completion(.failure(NetworkError.invalidResponse(data)))
                    return
                }
                
                completion(.success(results))
            }
    }
    
    func getRecipeDetails(
        id recipeId: Int,
        completion: @escaping ((Result<RecipeDetailsResponse, Error>) -> ())
    ) {
        var queryParams = ["includeNutrition": "false"]
        addApiKeyToParams(&queryParams)
        
        AF.request("\(RecipeAPI.baseUrl)/recipes/\(recipeId)/information", parameters: queryParams)
            .response { response in
                do {
                    try NetworkError.mapResponse(response: (data: response.data, response: response.response))
                } catch {
                    completion(.failure(error))
                }
                
                guard let data = response.data else {
                    if let error = response.error {
                        completion(.failure(error))
                    }
                    return
                }
                guard let results = try? JSONDecoder()
                    .decode(RecipeDetailsResponse.self, from: data) else {
                    completion(.failure(NetworkError.invalidResponse(data)))
                    return
                }
                
                completion(.success(results))
            }
    }
}
