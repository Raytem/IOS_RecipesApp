//
//  TextUtil.swift
//  RecipeBook
//
//  Created by Daniil on 15.01.25.
//


struct TextUtil {
    static func firstLetterCapitalized(_ text: String) -> String {
        guard let first = text.first else { return text }
        return first.uppercased() + text.dropFirst()
    }
}
