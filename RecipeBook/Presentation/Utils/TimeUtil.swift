//
//  TimeUtil.swift
//  RecipeBook
//
//  Created by Daniil on 16.01.25.
//

import SwiftUI


struct TimeUtil {
    static func fromMinutesToLocalizedTimeString(min minutes: Int) -> LocalizedStringKey {
        if minutes >= 60 {
            let hours = minutes / 60
            let minutesWithoutHours = minutes - hours * 60
            
            if (minutesWithoutHours > 0) {
                return "\(hours)h \(minutesWithoutHours)min"
            }
            return "\(hours)h"
        }
        
        return "\(minutes)min"
    }
}
