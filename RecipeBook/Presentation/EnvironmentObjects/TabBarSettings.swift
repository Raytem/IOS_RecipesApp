//
//  TabBarSettings.swift
//  RecipeBook
//
//  Created by Daniil on 15.01.25.
//

import Foundation
import SwiftUI


class TabBarSettings: ObservableObject {
    @Published var isShadowShowing: Bool = true
    @Published var shadowAnimation: Animation = .linear(duration: 0.2)
}
