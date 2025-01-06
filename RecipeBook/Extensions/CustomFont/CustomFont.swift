//
//  CustomFont.swift
//  RecipeBook
//
//  Created by Daniil on 5.01.25.
//

import SwiftUI

extension Font {
    static func poppins(type: FontType = .normal) -> Font {
        guard let fontTypeSettings = fontTypeSettingsTable[type] else {
            fatalError("No font type settings found")
        }
        
        let font = Font.custom("Poppins-Regular", size: fontTypeSettings.size)
        
        return font
    }
}

