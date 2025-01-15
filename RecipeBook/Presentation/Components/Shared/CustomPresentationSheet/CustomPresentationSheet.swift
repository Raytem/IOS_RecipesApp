//
//  CustomPresentationSheet.swift
//  RecipeBook
//
//  Created by Daniil on 15.01.25.
//

import SwiftUI

struct CustomPresentationSheet<Content: View>: View {
    @Environment(\.dismiss) var dismiss
    
    var title: LocalizedStringKey
    @ViewBuilder var content: Content
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .lineLimit(1)
                Spacer()
                Image(systemName: "xmark")
                    .foregroundStyle(.gray)
                    .font(.title2)
                    .onTapGesture {
                        dismiss()
                    }
            }
            .padding(
                EdgeInsets(top: 15, leading: 15, bottom: 5, trailing: 15)
            )
            
            ScrollView(.vertical) {
                VStack {
                    content
                }
                .padding(.horizontal, 15)
            }
        }
        .background(.backgroundLayer1)
        .presentationDragIndicator(.visible)
        .presentationCornerRadius(25)
    }
}

#Preview {
    CustomPresentationSheet(
        title: "Title"
    ) {
        Text("content")
    }
}
