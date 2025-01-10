//
//  RecipeCardView.swift
//  RecipeBook
//
//  Created by Daniil on 8.01.25.
//

import SwiftUI

struct RecipeCard: View {
    @State public var viewModel: RecipeCardViewModel
    
    @Binding public var viewType: RecipeCardViewType
    
    @State private var imageHeight: CGFloat = 0
    @State private var imageWidth: CGFloat = 0
    @State private var cardHeight: CGFloat = 0
    @State private var buttonAlignment: Alignment = .center
    @State private var isStackVertical: Bool = true
    
    init(
        viewModel: RecipeCardViewModel,
        viewType: Binding<RecipeCardViewType>
    ) {
        self.viewModel = viewModel
        self._viewType = viewType
        self.imageHeight = imageHeight
        self.cardHeight = cardHeight
        self.buttonAlignment = buttonAlignment
        self.isStackVertical = isStackVertical
    }
    
    var body: some View {
        DynamicStack(
            isVertical: $isStackVertical,
            alignment: .leading,
            spacing: 0
        ) {
            // Image block
            ZStack {
                Color(.backgroundMain)
                AsyncImage(url: viewModel.recipeModel.image) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .scaleEffect(1.5)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    case .failure:
                        Image(systemName: "photo.badge.exclamationmark")
                            .font(.system(.largeTitle))
                            .foregroundColor(.white)
                    default:
                        EmptyView()
                    }
                }
            }
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
                ).opacity(0.7)
                
                VStack(alignment: .leading, spacing: 0) {
                    Spacer()
                    
                    HStack(alignment: .top, spacing: 5) {
                        Image(systemName: "clock")
                        Text("\(viewModel.recipeModel.readyInMinutes) min")
                            .lineLimit(1)
                        Spacer()
                    }
                    .foregroundStyle(.white)
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
                        .font(.headline)
                        .lineLimit(2)
                        .truncationMode(.tail)
                    
                    Text(
                        viewModel.recipeModel.diets.map({ diet in diet.rawValue }).joined(separator: ", ")
                    )
                        .font(.callout)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    HStack {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.red)
                        Text("\(viewModel.recipeModel.aggregateLikes) likes")
                            .font(.callout)
                            .lineLimit(1)
                    }
                }
                
                Spacer()
                
                CustomButton(
                    title: "Add to saved",
                    size: .medium,
                    startIcon: "bookmark.fill",
                    action: {
                        //TODO
                    }
                )
                .frame(
                    maxWidth: .infinity,
                    alignment: buttonAlignment
                )
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(5)
        }
        .frame(height: cardHeight)
        .background(.backgroundMain)
        
        .onAppear() {
            updateSettings(for: viewType)
        }
        .onChange(of: viewType) {
            updateSettings(for: viewType)
        }
    }
    
    private func updateSettings(for viewType: RecipeCardViewType) {
        let settings = getRecipeCardSettings(for: viewType)
        imageHeight = settings.imageHeight
        imageWidth = settings.imageWidth
        cardHeight = settings.cardHeight
        buttonAlignment = settings.buttonAlignment
        isStackVertical = settings.isStackVertical
    }
}

#Preview {
    RecipeCard(
        viewModel: RecipeCardViewModel(
            recipeModel: recipeCardMockData[0]
        ),
        viewType: .constant(.grid)
    )
}
