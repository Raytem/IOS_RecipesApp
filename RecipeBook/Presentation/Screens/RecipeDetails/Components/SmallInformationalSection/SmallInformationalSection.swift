//
//  SmallInformationalSection.swift
//  RecipeBook
//
//  Created by Daniil on 15.01.25.
//

import SwiftUI

struct SmallInformationalSection: View {
    var imageSystemName: String
    var imageColor: Color? = nil
    var title: LocalizedStringKey
    var desctiption: LocalizedStringKey
    
    var body: some View {
        RecipeDetailsSection {
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top, spacing: 5) {
                    if let color = imageColor {
                        Image(systemName: imageSystemName)
                            .foregroundStyle(color)
                    } else {
                        Image(systemName: imageSystemName)
                    }
                    Text(title)
                        .lineLimit(1)
                    Spacer()
                }
                .font(.headline)
                .fontWeight(.semibold)
                
                Text(desctiption)
                    .font(.callout)
                    .foregroundStyle(.gray)
                    .lineLimit(1)
            }
        } topOutOfPaddingContent: {}
    }
}

#Preview {
    SmallInformationalSection(
        imageSystemName: "heart.fill",
        imageColor: .red,
        title: "12",
        desctiption: "likes"
    )
}
