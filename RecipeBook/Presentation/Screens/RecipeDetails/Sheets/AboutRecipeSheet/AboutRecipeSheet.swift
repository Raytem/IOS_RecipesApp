//
//  AboutRecipeSheet.swift
//  RecipeBook
//
//  Created by Daniil on 15.01.25.
//

import SwiftUI

struct AboutRecipeSheet: View {
    var viewModel: AboutRecipeSheetViewModel
    
    var body: some View {
        CustomPresentationSheet(title: "About recipe") {
            VStack(alignment: .leading, spacing: 40) {
                ForEach(
                    viewModel.getKeyValueTablesFromDetails(),
                    id: \.id
                ) { table in
                    VStack(alignment: .leading, spacing: 15) {
                        Text(table.title)
                            .font(.headline)
                        
                        ForEach(table.rows, id: \.value) { row in
                            HStack(alignment: .top, spacing: 20) {
                                HStack {
                                    Text(row.key)
                                        .foregroundStyle(.gray)
                                }
                                .frame(maxWidth: 120, alignment: .leading)
                                
                                Text(row.value.isEmpty ? "–" : row.value)
                            }
                        }
                        .font(.callout)
                    }
                }
                
                Text(viewModel.recipeDetailsModel.summary.htmlToString())
                    .font(.callout)
            }
            .padding(.top, 20)
        }
    }
}

#Preview {
    AboutRecipeSheet(
        viewModel: AboutRecipeSheetViewModel(
            recipeDetailsModel: recipeDetailsMockData
        )
    )
}
