//
//  CustomButton.swift
//  RecipeBook
//
//  Created by Daniil on 10.01.25.
//

import SwiftUI

struct CustomButton: View {
    var title: LocalizedStringKey
    var color: ButtonColor
    var size: ButtonSize
    var variant: ButtonVariant
    var fontWeight: Font.Weight
    var startIcon: String?
    var endIcon: String?
    var fullWidth: Bool
    var withShadow: Bool
    var disabled: Bool
    var action: () -> Void
    
    @State private var isPressed: Bool = false
    
    init(
        title: LocalizedStringKey = "",
        color: ButtonColor = .primary,
        size: ButtonSize = .medium,
        variant: ButtonVariant = .contained,
        fontWeight: Font.Weight = .semibold,
        startIcon: String? = nil,
        endIcon: String? = nil,
        fullWidth: Bool = false,
        withShadow: Bool = false,
        disabled: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.color = color
        self.size = size
        self.variant = variant
        self.fontWeight = fontWeight
        self.startIcon = startIcon
        self.endIcon = endIcon
        self.fullWidth = fullWidth
        self.withShadow = withShadow
        self.disabled = disabled
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
        case .primary: Color.primary50.opacity(0.6)
        case .secondary: Color.secondary40.opacity(0.6)
        }
        return color
    }
    
    private var padding: EdgeInsets {
        switch size {
        case .small:
            return EdgeInsets(top: 8, leading: 13, bottom: 8, trailing: 13)
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
        case .small: return .subheadline.weight(.bold)
        case .medium: return .body.weight(.bold)
        case .large: return .title3.weight(.bold)
        }
    }
    
    var body: some View {
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
        .frame(maxWidth: fullWidth == true ? .infinity : nil)
        .buttonStyle(.plain)
        .padding(padding)

        .disabled(disabled)
        
        
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
        .overlay {
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(borderColor, lineWidth: 2)
        }
        
        .font(font)
        .fontWeight(fontWeight)
        .foregroundStyle(foregroundColor)
        .shadow(color: withShadow ? shadowColor : Color.clear, radius: 15, x: 0, y: 3)
        
        .scaleEffect(isPressed ? 0.97 : 1)
        .onTapGesture {
            if !disabled {
                action()
            }
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    withAnimation(.spring(duration: 0.5)) {
                        isPressed = true
                    }
                }
                .onEnded { _ in isPressed = false
                    withAnimation(.spring(duration: 0.5)) { isPressed = false }
                }
        )
    }
}

#Preview {
    CustomButton(
        title: "Click",
        color: .primary,
        size: .small,
        variant: .contained,
        startIcon: "heart",
        fullWidth: false,
        withShadow: true,
        disabled: false,
        action: { print("tap") }
    )
}
