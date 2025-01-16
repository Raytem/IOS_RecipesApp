//
//  NumberUtil.swift
//  RecipeBook
//
//  Created by Daniil on 16.01.25.
//

import Foundation


struct NumberUtil {
    
    static func getFormattedNumber(_ amount: Double, decimalPlacesNumber: Int = 2) -> String {
        var format = "%.0f"
        if (amount - ceil(amount) != 0) {
            format = "%.\(decimalPlacesNumber)f"
        }
        return String(format: format, amount)
    }
}
