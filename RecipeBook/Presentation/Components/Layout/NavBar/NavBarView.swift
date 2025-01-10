//
//  NavBarView.swift
//  RecipeBook
//
//  Created by Daniil on 5.01.25.
//

import SwiftUI

struct NavBarView: View {
    @Binding public var selectedTab: NavBarTab
    
    @State private var navBarTabsModels: [NavBarTabModel] = [
        .init(tab: .main, imageName: "house"),
        .init(tab: .savedRecipes, imageName: "bookmark"),
        .init(tab: .settings, imageName: "gear")
    ]
    
    var body: some View {
            HStack(spacing: 0) {
                ForEach($navBarTabsModels, id: \.tab) { $tabModel in
                    HStack {
                        Image(systemName: tabModel.imageName)
                        .symbolEffect(.bounce.down.byLayer, value: tabModel.isAnimating)
                        .foregroundStyle(
                            selectedTab == tabModel.tab
                            ? Color(uiColor: .primary50)
                            : Color(uiColor: .neaturalGray3)
                        )
                        .font(.system(size: 24))
                    }
                    .frame(maxWidth: .infinity)
                    .contentShape(.rect)
                    .padding(.vertical, 10)
                    .onTapGesture {
                        withAnimation(.bouncy, completionCriteria: .logicallyComplete, {
                            selectedTab = tabModel.tab
                            tabModel.isAnimating = true
                        }, completion: {
                            var transaction = Transaction()
                            transaction.disablesAnimations = true
                            withTransaction(transaction) {
                                tabModel.isAnimating = nil
                            }
                        })
                    }
                }
            }
            .background(
                Color(.backgroundLayer1)
                    .shadow(color: .black.opacity(0.05), radius: 4, y: -4)
                    .ignoresSafeArea(edges: .bottom)
            )
        }
}

#Preview {
    NavBarView(
        selectedTab: .constant(.main)
    )
}
