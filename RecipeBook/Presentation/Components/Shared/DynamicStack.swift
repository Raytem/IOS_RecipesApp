//
//  DynamicStackView.swift
//  RecipeBook
//
//  Created by Daniil on 8.01.25.
//

import SwiftUI

struct DynamicStack<Content: View>: View {
    @Binding public var isVertical: Bool
    @State public var alignment: HorizontalAlignment = .center
    @State  var spacing: CGFloat? = nil
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
    DynamicStack(isVertical: .constant(true)) {
        Text("Hi")
        Text("Hi")
    }
}
