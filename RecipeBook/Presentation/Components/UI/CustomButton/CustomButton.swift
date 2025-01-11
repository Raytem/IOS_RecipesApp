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
    var variant: ButtonVariant
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
        variant: ButtonVariant = .contained,
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
        self.variant = variant
        self.startIcon = startIcon
        self.endIcon = endIcon
        self.fullWidth = fullWidth
        self.withShadow = withShadow
        self._disabled = disabled
        self.action = action
    }
    
    private let primaryColor: Color = .primary50
    private let secondaryColor: Color = .secondary60
    private let disabledColor: Color = .neaturalGray3
    
    
    private var backgroundColor: Color {
        var bg: Color
        switch variant {
        case .contained:
            if disabled {
                bg = disabledColor
                break
            }
            
            bg = switch color {
            case .primary: primaryColor
            case .secondary: secondaryColor
            }
        case .outlined, .text:
            bg = Color.clear
        }
        return bg
    }
    
    private var borderColor: Color {
        var border: Color
        switch variant {
        case .contained, .text:
            border = Color.clear
        case .outlined:
            if disabled {
                border = disabledColor
                break
            }
            
            border = switch color {
            case .primary: primaryColor
            case .secondary: secondaryColor
            }
        }

        return border
    }
    
    private var foregroundColor: Color {
        var foreground: Color
        switch variant {
        case .contained:
            foreground = .neaturalWhite
        case .outlined, .text:
            if disabled {
                foreground = disabledColor
                break
            }
            
            foreground = switch color {
            case .primary: primaryColor
            case .secondary: secondaryColor
            }
        }

        return foreground
    }
    
    private var shadowColor: Color {
        if disabled {
            return .neaturalBlack.opacity(0.3)
        }
        
        let color = switch color {
        case .primary: Color.primary50
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
        .frame(maxWidth: fullWidth == true ? .infinity : nil)
        
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
        .overlay {
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(borderColor, lineWidth: 2)
        }
        
        .font(font)
        .foregroundStyle(foregroundColor)
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
        color: .secondary,
        size: .medium,
        variant: .contained,
        startIcon: "heart",
        withShadow: true,
        disabled: .constant(false)
    ) {}
}
