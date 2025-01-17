//
//  Tab.swift
//  RecipeBook
//
//  Created by Daniil on 17.01.25.
//

import SwiftUI

struct Tab: View {
    var tabModel: NavBarTabModel
    @Binding var selectedTab: NavBarTab
    
    var body: some View {
        HStack {
            Image(systemName: tabModel.imageName)
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
            selectedTab = tabModel.tab
        }
    }
}

#Preview {
    Tab(
        tabModel: NavBarTabModel(tab: .main, imageName: "houst"),
        selectedTab: .constant(.main)
    )
}
