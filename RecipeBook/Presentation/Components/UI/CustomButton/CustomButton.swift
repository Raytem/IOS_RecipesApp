//
//  CustomButton.swift
//  RecipeBook
//
//  Created by Daniil on 10.01.25.
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var color: ButtonColor
    var size: ButtonSize
    var startIcon: String?
    var endIcon: String?
    var fullWidth: Bool
    var withShadow: Bool
    @Binding var disabled: Bool
    var action: () -> Void
    
    @State private var isPressed: Bool = false
    
    init(
        title: String = "",
        color: ButtonColor = .primary,
        size: ButtonSize = .medium,
        startIcon: String? = nil,
        endIcon: String? = nil,
        fullWidth: Bool = false,
        withShadow: Bool = false,
        disabled: Binding<Bool> = .constant(false),
        action: @escaping () -> Void
    ) {
        self.title = title
        self.color = color
        self.size = size
        self.startIcon = startIcon
        self.endIcon = endIcon
        self.fullWidth = fullWidth
        self.withShadow = withShadow
        self._disabled = disabled
        self.action = action
    }
    
    
    private var backgroundColor: Color {
        let color = switch color {
        case .primary: Color.primary50
        case .secondary: Color.secondary60
        }
        return color
    }
    
    private var shadowColor: Color {
        let color = switch color {
        case .primary: Color.primary40
        case .secondary: Color.secondary40
        }
        return color
    }
    
    private var padding: EdgeInsets {
        switch size {
        case .small:
            return EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        case .medium:
            return EdgeInsets(top: 13, leading: 20, bottom: 13, trailing: 20)
        case .large:
            return EdgeInsets(top: 20, leading: 45, bottom: 20, trailing: 45)
        }
    }

    private var cornerRadius: CGFloat {
        switch size {
        case .small: return 8
        case .medium: return 12
        case .large: return 16
        }
    }

    private var font: Font {
        switch size {
        case .small: return .callout.weight(.bold)
        case .medium: return .body.weight(.bold)
        case .large: return .title3.weight(.bold)
        }
    }

    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                if let startIcon {
                    Image(systemName: startIcon)
                }
                
                Text(title)
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                if let endIcon {
                    Image(systemName: endIcon)
                }
            }
        }
        .buttonStyle(.plain)
        .padding(padding)
        
        .disabled(disabled)
        .overlay {
            disabled ? Color(.neaturalGray4).opacity(0.4) : Color.clear
        }
        .frame(maxWidth: fullWidth == true ? .infinity : nil)
        
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
        
        .font(font)
        .foregroundStyle(.neaturalWhite)
        .shadow(color: withShadow ? shadowColor : Color.clear, radius: 10, x: 0, y: 5)
        
        .scaleEffect(isPressed ? 0.95 : 1)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    withAnimation(.spring(duration: 0.2)) { isPressed = true }
                }
                .onEnded { _ in isPressed = false
                    withAnimation(.spring(duration: 0.2)) { isPressed = false }
                }
        )
    }
}

#Preview {
    CustomButton(
        title: "Click",
        size: .medium,
        startIcon: "heart",
        disabled: .constant(false)
    ) {}
}
