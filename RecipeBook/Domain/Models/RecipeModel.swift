import SwiftUI

struct RecipeModel: Identifiable {
    var id: Int
    var title: String
    var image: URL?
    var readyInMinutes: Int
    var aggregateLikes: Int
    var diets: [Diet]
}
