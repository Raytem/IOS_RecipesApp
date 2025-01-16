//
//  DynamicStackView.swift
//  RecipeBook
//
//  Created by Daniil on 8.01.25.
//

import SwiftUI

struct DynamicStack<Content: View>: View {
    var isVertical: Bool
    var horizontalAlignment: HorizontalAlignment = .center
    var verticalAlignment: VerticalAlignment = .center
    var spacing: CGFloat? = nil
    @ViewBuilder public var content: () -> Content
    
    var body: some View {
        if isVertical {
            VStack(alignment: horizontalAlignment, spacing: spacing) {
                content()
            }
        } else {
            HStack(alignment: verticalAlignment, spacing: spacing) {
                content()
            }
        }
    }
}

#Preview {
    DynamicStack(isVertical: true) {
        Text("Hi")
        Text("Hi")
    }
}
