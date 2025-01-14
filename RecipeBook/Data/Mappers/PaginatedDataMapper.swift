//
//  PaginatedDataMapper.swift
//  RecipeBook
//
//  Created by Daniil on 14.01.25.
//


struct PaginatedDataMapper {
    static func mapFromPaginatedDataResponse<Item>(
        _ resp: PaginatedDataResponse<Item>
    ) -> PaginatedDataModel<Item> {
        let curPage = resp.offset + 1
        let lastPage = resp.totalResults / (resp.number <= 0 ? 1 : resp.number)
        
        return PaginatedDataModel(
            data: resp.results,
            currentPage: curPage,
            lastPage: lastPage,
            totalResults: resp.totalResults,
            itemsOnPage: resp.number
        )
    }
}
