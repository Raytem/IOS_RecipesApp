import SwiftUI

struct RecipeModel: Identifiable, Equatable {
    var id: Int
    var title: String
    var image: URL?
    var readyInMinutes: Int
    var aggregateLikes: Int
    var diets: [Diet]
}
