//
//  RecipeRepository.swift
//  RecipeBook
//
//  Created by Daniil on 14.01.25.
//

final class RecipeRepository {
    static let shared = RecipeRepository()
    
    func getManyRecipes(
        query: String? = nil,
        filters: SearchRecipesFilter? = nil,
        sortBy: SearchRecipesSortOption? = nil,
        page: Int?,
        perPage: Int?,
        completion: (@escaping (Result<PaginatedDataModel<RecipeModel>, Error>) -> ())
    ) {
        let calculatedOffset = max(0, ((page ?? 1) - 1) * (perPage ?? 10))
        
        let queryParams = ComplexSearchRequestParameters(
            pagination: PaginationParameters(
                offset: calculatedOffset,
                number: perPage
            ),
            sort: mapSortOptionToApiParams(sortBy),
            query: query,
            cuisines: filters?.cuisines,
            diets: filters?.diets,
            mealTypes: filters?.mealTypes,
            maxReadyTime: filters?.maxReadyTime
        )

        RecipeAPI.shared.complexRecipeSearch(
            parameters: queryParams
        ) { result in
            switch result {
            case .success(let data):
                let mappedData = PaginatedDataMapper
                    .mapFromPaginatedDataResponse(data)
                    .mapData { RecipeMapper.mapFromComplexSearchResponse($0) }
                  
                completion(.success(mappedData))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getRelatedRecipes(
        for recipeId: Int,
        completion: (@escaping (Result<[RecipeModel], Error>) -> ())
    ) {
        RecipeAPI.shared.getRelatedRecipes(for: recipeId) { result in
            switch result {
            case .success(let data):
                RecipeAPI.shared.getRecipesInformatioinBulk(
                    ids: data.map { $0.id }
                ) { result in
                    switch result {
                    case .success(let data2):
                        let mappedData = data2.map { RecipeMapper.mapFromComplexSearchResponse($0) }
                        completion(.success(mappedData))
                        
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getRecipeDetails(
        id recipeId: Int,
        completion: (@escaping (Result<RecipeDetailsModel, Error>) -> ())
    ) {
        RecipeAPI.shared.getRecipeDetails(id: recipeId) { result in
            switch result {
            case .success(let data):
                let mappedData = RecipeDetailsMapper
                    .mapFormDetailsResponse(data)
                completion(.success(mappedData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func mapSortOptionToApiParams(_ sortBy: SearchRecipesSortOption?) -> SortParameters<ComplesSearchRecipeSortingOption>? {
        guard let sortBy else { return nil }
        
        return switch sortBy {
        case .harmful:
            .init(sort: .healthiness, sortDirection: .ascending)
        case .healthy:
            .init(sort: .healthiness, sortDirection: .descending)
        case .lessIngridients:
            .init(sort: .maxUsedIngredients, sortDirection: .ascending)
        case .moreIngridients:
            .init(sort: .maxUsedIngredients, sortDirection: .descending)
        case .popular:
            .init(sort: .popularity, sortDirection: .descending)
        case .quickToCook:
            .init(sort: .time, sortDirection: .ascending)
        case .theLeastCaloric:
            .init(sort: .calories, sortDirection: .ascending)
        case .theMostHighCalorie:
            .init(sort: .calories, sortDirection: .descending)
        }
    }
}
