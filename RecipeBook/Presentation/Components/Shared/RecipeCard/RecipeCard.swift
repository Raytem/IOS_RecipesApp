//
//  RecipeCardView.swift
//  RecipeBook
//
//  Created by Daniil on 8.01.25.
//

import SwiftUI
import SwiftData


struct RecipeCard: View {
    @Environment(\.modelContext) var modelContext: ModelContext
    @State public var viewModel: RecipeCardViewModel
    @Binding var viewType: RecipeCardViewType
    
    private var buttonTitle: String {
        viewModel.isSaved
        ? String(localized: "Saved", table: "RecipeCard")
        : String(localized: "Save", table: "RecipeCard")
    }
    
    private var buttonIcon: String {
        viewModel.isSaved ? "checkmark" : "bookmark.fill"
    }
    
    private var isStackVertical: Bool {
        RecipeCardSettings.get(for: viewType).isStackVertical
   }
    
    private var imageHeight: CGFloat? {
        RecipeCardSettings.get(for: viewType).imageHeight
   }
   
    private var imageWidth: CGFloat? {
        RecipeCardSettings.get(for: viewType).imageWidth
    }

    private var cardHeight: CGFloat? {
        RecipeCardSettings.get(for: viewType).cardHeight
    }

    private var buttonAlignment: Alignment {
        RecipeCardSettings.get(for: viewType).buttonAlignment
    }
    
    private var buttonFullWidth: Bool {
        RecipeCardSettings.get(for: viewType).buttonFullWidth
    }
    
    var body: some View {
        DynamicStack(
            isVertical: isStackVertical,
            horizontalAlignment: .leading,
            verticalAlignment: .top,
            spacing: 10
        ) {
            // Image block
            CustomAsyncImage(
                url: viewModel.recipeModel.image
            )
            .overlay() {
                LinearGradient(
                    colors: [
                        .black,
                        .clear,
                        .clear,
                        .clear
                    ],
                    startPoint: .bottom,
                    endPoint: .top
                ).opacity(0.8)
                
                VStack(alignment: .leading, spacing: 0) {
                    Spacer()
                    
                    HStack(alignment: .top, spacing: 5) {
                        Image(systemName: "clock")
                        Text(TimeUtil.fromMinutesToLocalizedTimeString(min: viewModel.recipeModel.readyInMinutes))
                            .lineLimit(1)
                        Spacer()
                    }
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.neaturalGray4)
                }
                .frame(maxWidth: .infinity)
                .padding(7)
            }
            .frame(width: imageWidth, height: imageHeight)
            .cornerRadius(20)
            .clipped()
            
            // Card info
            VStack(alignment: .leading, spacing: 0) {
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(viewModel.recipeModel.title)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(.label))
                        .lineLimit(2)
                        .truncationMode(.tail)
                        .multilineTextAlignment(.leading)
                    
                    if !viewModel.recipeModel.diets.isEmpty {
                        Text(
                            viewModel.recipeModel.diets
                                .map({ diet in diet.displayName })
                                .sorted(by: <)
                                .joined(separator: ", ")
                        )
                        .font(.footnote)
                        .foregroundStyle(Color(.label))
                        .lineLimit(1)
                        .truncationMode(.tail)
                    }
                    
                    HStack {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.red)
                        Text("\(viewModel.recipeModel.aggregateLikes) likes")
                            .font(.footnote)
                            .lineLimit(1)
                            .foregroundStyle(.gray)
                    }
                }
                
                Spacer()
                
                CustomButton(
                    title: "\(buttonTitle)",
                    isInverted: viewModel.isSaved ? true : false,
                    size: .medium,
                    startIcon: buttonIcon,
                    fullWidth: buttonFullWidth,
                    action: handleAddToSavedButtonClick
                )
                .frame(
                    maxWidth: .infinity,
                    alignment: buttonAlignment
                )
                .padding(.horizontal, 5)
                
            }
            .padding(5)
        }
        .frame(height: cardHeight)
        .background(.clear)
        
        .onAppear {
            viewModel.modelContext = modelContext
            viewModel.updateIsSavedState()
        }
        .onNotification(.savedRecipesDidUpdated) {
            viewModel.updateIsSavedState()
        }
    }
    
    func handleAddToSavedButtonClick() {
        withAnimation(.spring(duration: 0.2)) {
            viewModel.addToSavedOrRemove()
        }
    }
}

#Preview {
    RecipeCard(
        viewModel: RecipeCardViewModel(
            recipeModel: recipeCardMockData[0]
        ),
        viewType: .constant(.grid)
    )
    .modelContainer(for: SavedRecipeModel.self, inMemory: true)
}
