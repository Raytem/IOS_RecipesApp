//
//  RecipeDetailsSection.swift
//  RecipeBook
//
//  Created by Daniil on 15.01.25.
//

import SwiftUI

struct RecipeDetailsSection<Content: View, OutOfPaddingContent: View>: View {
    var title: LocalizedStringKey? = nil
    @ViewBuilder var content: Content
    @ViewBuilder var topOutOfPaddingContent: OutOfPaddingContent
    
    var body: some View {
        VStack(alignment: .leading) {
            topOutOfPaddingContent
            VStack(alignment: .leading, spacing: 0) {
                if let title {
                    HStack {
                        Text(title)
                            .font(.headline)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.bottom, 8)
                }
                content
                    .font(.callout)
            }
            .padding(15)
        }
            .frame(maxWidth: .infinity)
            .background(.backgroundLayer1)
            .cornerRadius(20)
            
    }
}

#Preview {
    RecipeDetailsSection(
        title: "Title"
    ) {
        Text("RecipeDetailsSection")
    } topOutOfPaddingContent: {}
    .background(.red)
}
