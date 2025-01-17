//
//  Checkmark.swift
//  RecipeBook
//
//  Created by Daniil on 17.01.25.
//

import SwiftUI

struct Checkmark: View {
    var isActive: Bool
    var activeColor: Color = .primary50
    var disabledColor: Color = .gray
    
    var body: some View {
        HStack {
            if (isActive) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(activeColor)
            } else {
                Image(systemName: "circle")
                    .foregroundStyle(disabledColor)
            }
        }
        .font(.system(size: 20))
    }
}

#Preview {
    Checkmark(
        isActive: false
    )
}
