//
//  FloatingActionBar.swift
//  RecipeBook
//
//  Created by Daniil on 15.01.25.
//

import SwiftUI

enum FloatingActionBarPosition {
    case top, bottom
}

struct FloatingActionBar<Content: View>: View {
    var position: FloatingActionBarPosition = .bottom
    var backgroundColor: Color = Color(.label)
    @ViewBuilder var content: Content
    
    var barCornerRadius: CGFloat = 20
    
    var shadowY: CGFloat {
        switch position {
        case .top: 4
        case .bottom: -4
        }
    }
    
    var rectangleCornerRadii: RectangleCornerRadii {
        switch position {
        case .top:
            .init(
                bottomLeading: barCornerRadius,
                bottomTrailing: barCornerRadius
            )
        case .bottom:
            .init(
                topLeading: barCornerRadius,
                topTrailing: barCornerRadius
            )
        }
    }
    
    var body: some View {
        VStack {
            if position == .bottom {
                Spacer()
            }
            HStack {
                content
            }
            .padding(10)
            .frame(maxWidth: .infinity)
            .background()
            .clipShape(
                UnevenRoundedRectangle(
                    cornerRadii: rectangleCornerRadii
                )
            )
            
            if position == .top {
                Spacer()
            }
           
        }
        .shadow(color: .shadow, radius: 4, y: shadowY)
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    FloatingActionBar(
        position: .top
    ) {
        Text("Hello")
    }
}
