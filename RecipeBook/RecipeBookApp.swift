//
//  RecipeBookApp.swift
//  RecipeBook
//
//  Created by Daniil on 5.01.25.
//

import SwiftUI
import SwiftData

@main
struct RecipeBookApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            SavedRecipeModel.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    init() {
        AppearanceManager.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .accentColor(.primary50)
        }
        .modelContainer(sharedModelContainer)
    }
}
