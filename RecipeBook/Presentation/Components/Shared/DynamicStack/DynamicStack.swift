//
//  DynamicStackView.swift
//  RecipeBook
//
//  Created by Daniil on 8.01.25.
//

import SwiftUI

struct DynamicStack<Content: View>: View {
    var isVertical: Bool
    var alignment: HorizontalAlignment = .center
    var spacing: CGFloat? = nil
    @ViewBuilder public var content: () -> Content
    
    var body: some View {
        Group {
            if isVertical {
                VStack() {
                    content()
                }
            } else {
                HStack {
                    content()
                }
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
