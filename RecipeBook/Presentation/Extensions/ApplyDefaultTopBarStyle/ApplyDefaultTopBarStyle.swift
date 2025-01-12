//
//  DefaultTopBarStyleExtension.swift
//  RecipeBook
//
//  Created by Daniil on 12.01.25.
//

import SwiftUI

extension View {
    
    func applyDefaultTopBarStyle() -> some View {
        self
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.primary50, for: .navigationBar)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            .accentColor(.toolbarItemAccent)
    }
}
