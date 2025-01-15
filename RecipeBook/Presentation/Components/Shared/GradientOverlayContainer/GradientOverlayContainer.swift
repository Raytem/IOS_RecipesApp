//
//  GradientOverlayContainer.swift
//  RecipeBook
//
//  Created by Daniil on 15.01.25.
//

import SwiftUI

struct GradientOverlayContainer<Content: View>: View {
    enum GradientSide {
        case left, right
    }
    
    var gradientSide: GradientSide
    var color: Color
    var gradientWidth: CGFloat
    let content: Content
    
    @State private var contentHeight: CGFloat = 0

    var gradient: LinearGradient {
        switch gradientSide {
        case .left:
            LinearGradient(
                colors: [color, .clear],
                startPoint: .trailing,
                endPoint: .leading
            )
        case .right:
            LinearGradient(
                colors: [color, .clear],
                startPoint: .leading,
                endPoint: .trailing
            )
        }
    }

    init(
        gradientSide: GradientSide,
        color: Color = Color(.label),
        gradientWidth: CGFloat = 50,
        @ViewBuilder content: () -> Content
    ) {
        self.gradientSide = gradientSide
        self.color = color
        self.gradientWidth = gradientWidth
        self.content = content()
    }

    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                if gradientSide == .left {
                    gradient
                        .frame(width: gradientWidth, height: contentHeight)
                }
                content
                    .background(color)
                    .background(
                        GeometryReader { geometry in
                            Color.clear
                                .onAppear {
                                    contentHeight = geometry.size.height
                                }
                                .onChange(of: geometry.size.height) { newValue in
                                    contentHeight = newValue
                                }
                        }
                    )
                if gradientSide == .right {
                    gradient
                        .frame(width: gradientWidth, height: contentHeight)
                }
            }
        }
    }
}

#Preview {
    GradientOverlayContainer(
        gradientSide: .left,
        color: .red
    ) {
        Text("hello")
    }
}
