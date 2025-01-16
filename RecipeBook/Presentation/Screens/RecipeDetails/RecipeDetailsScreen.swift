//
//  RecipeDetailsScreen.swift
//  RecipeBook
//
//  Created by Daniil on 15.01.25.
//

import SwiftUI

struct RecipeDetailsScreen: View {
    @EnvironmentObject var tabBarSettings: TabBarSettings
    @State var viewModel: RecipeDetailsViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView(.vertical) {
                    VStack(spacing: 10) {
                        ImageSection(
                            recipeDetailsPreview: viewModel.recipeDetailsPreview
                        )
                        
                        if let recipeDetails = viewModel.recipeDetailsModel {
                            HStack(spacing: 10) {
                                SmallInformationalSection(
                                    imageSystemName: "clock",
                                    title: TimeUtil.fromMinutesToLocalizedTimeString(min: recipeDetails.readyInMinutes),
                                    desctiption: "Ready time"
                                )
                                SmallInformationalSection(
                                    imageSystemName: "heart.fill",
                                    imageColor: .red,
                                    title: "\(recipeDetails.aggregateLikes)",
                                    desctiption: "Likes"
                                )
                            }
                            
                            AboutRecipeSection(
                                recipeDetailsModel: recipeDetails
                            ).onTapGesture {
                                handleAboutRecipeSectionClick()
                            }
                            .sheet(isPresented: $viewModel.isAboutRecipeSheetShowing) {
                                AboutRecipeSheet(
                                    viewModel: AboutRecipeSheetViewModel(
                                        recipeDetailsModel: recipeDetails
                                    )
                                )
                            }
                            
                            IngredientsSection(
                                ingredients: recipeDetails.extendedIngredients
                            ).onTapGesture {
                                handleIngridientsSectionClick()
                            }
                            .sheet(isPresented: $viewModel.isIngredientsSheetShowing) {
                                IngredientsAndCookingStepsSheet(
                                    servings: recipeDetails.servings,
                                    ingredients: recipeDetails.extendedIngredients,
                                    cookingSteps: recipeDetails.cookingSteps
                                )
                            }
                            
                            .toolbar {
                                if !viewModel.isDetailsLoading {
                                    ToolbarItemGroup(placement: .topBarTrailing) {
                                        ShareLink(item: URL(string: recipeDetails.sourceUrl)!) {
                                            Image(systemName: "square.and.arrow.up")
                                        }
                                        .fontWeight(.semibold)
                                    }
                                }
                            }
                            
                            RecipeDetailsSection(title: "Related recipes") {
                                RecipeCardList(
                                    recipeModels: $viewModel.relatedRecipesModels,
                                    isLoading: $viewModel.isRelatedRecipesLoading,
                                    onScrollTargetAppear: {}
                                )
                            } topOutOfPaddingContent: {}
                        } else if (
                            viewModel.recipeDetailsModel == nil || viewModel.isDetailsLoading
                        ) {
                            RecipeDetailsBodySkeleton()
                        }
                    }
                }
                .scrollDisabled(viewModel.isDetailsLoading)
                .safeAreaPadding(.bottom, 80)
                
                FloatingActionBar(
                    position: .bottom,
                    backgroundColor: .backgroundLayer2
                ) {
                    CustomButton(
                        title: "Add to saved",
                        color: .primary,
                        startIcon: "bookmark.fill",
                        fullWidth: true,
                        action: handleAddToSavedClick
                    )
                }
            }
            .background(.backgroundMain)
            .applyCustomNavigationBarTitle(getNavbarTitle())
            .applyDefaultTopBarStyle()
        }
        .tint(.toolbarItemAccent)
        
        .onAppear {
            viewModel.fetchRecipeDetails()
            
            withAnimation(.linear(duration: 0.4)) {
                tabBarSettings.isShadowShowing = false
            }
        }
        .onDisappear {
            withAnimation(.linear(duration: 0.4)) {
                tabBarSettings.isShadowShowing = true
            }
        }
        
        // error alert
        .alert("An error has occurred", isPresented: $viewModel.isShowingErrorAlert) {
        } message: {
            Text("Сheck your internet connection or try again later")
        }
    }
    
    private func getNavbarTitle() -> LocalizedStringKey {
        let str = viewModel.recipeDetailsPreview?.title
            ?? viewModel.recipeDetailsModel?.title
            ?? ""
        return "\(str)"
    }
    
    private func handleAboutRecipeSectionClick() {
        viewModel.isAboutRecipeSheetShowing.toggle()
    }
    
    private func handleIngridientsSectionClick() {
        viewModel.isIngredientsSheetShowing.toggle()
    }
    
    private func handleAddToSavedClick() {
        
    }
}

#Preview {
    RecipeDetailsScreen(
        viewModel: RecipeDetailsViewModel(
            recipeId: 648715,
            recipeDetailsPreview: RecipeDetailsPreview(
                title: recipeDetailsMockData.title,
                image: recipeDetailsMockData.image
            )
        )
    )
    .environmentObject(TabBarSettings())
}
