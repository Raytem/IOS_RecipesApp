//
//  TabBadge.swift
//  RecipeBook
//
//  Created by Daniil on 17.01.25.
//

import SwiftUI

struct TabBadge: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 12))
            .fontWeight(.semibold)
            .foregroundStyle(Color.neaturalWhite)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(Color(.badge))
            .cornerRadius(100)
            .frame(minWidth: 20)
    }
}

#Preview {
    TabBadge(text: "2")
}
