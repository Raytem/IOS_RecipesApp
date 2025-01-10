import SwiftUI

struct RecipeModel: Identifiable {
    let id: Int
    let title: String
    let image: URL?
    let readyInMinutes: Int
    let aggregateLikes: Int
    let diets: [Diet]
}
