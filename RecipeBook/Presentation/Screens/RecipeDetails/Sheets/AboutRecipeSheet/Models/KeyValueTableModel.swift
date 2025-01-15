//
//  KeyValueTableModel.swift
//  RecipeBook
//
//  Created by Daniil on 15.01.25.
//

import SwiftUI


struct KeyValueTableModel {
    var id: Int
    var title: LocalizedStringKey
    var rows: [(key: LocalizedStringKey, value: String)]
}
