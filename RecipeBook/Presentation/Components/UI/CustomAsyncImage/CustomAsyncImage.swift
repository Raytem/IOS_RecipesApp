//
//  SwiftUIView.swift
//  RecipeBook
//
//  Created by Daniil on 11.01.25.
//

import SwiftUI

struct CustomAsyncImage: View {
    var url: URL?
    var contentMode: ContentMode
    var background: (() -> AnyView)?
    var onEmpty: (() -> AnyView)?
    var onFailure: (() -> AnyView)?
    
    init(
        url: URL? = nil,
        contentMode: ContentMode = .fit,
        background: (() -> AnyView)? = nil,
        onEmpty: (() -> AnyView)? = nil,
        onFailure: (() -> AnyView)? = nil
    ) {
        self.url = url
        self.contentMode = contentMode
        self.background = background
        self.onEmpty = onEmpty
        self.onFailure = onFailure
    }
    
    private var backgroundView: some View {
        background?() ?? AnyView(Color(.backgroundLayer2))
    }
      
    
      private var emptyView: some View {
          onEmpty?() ?? AnyView(EmptyView())
      }

      private var failureView: some View {
          onFailure?() ?? AnyView(
              Image(systemName: "photo.badge.exclamationmark")
                  .font(.system(.largeTitle))
                  .foregroundColor(.backgroundMain)
          )
      }
      
    
    var body: some View {
        ZStack {
            backgroundView
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    emptyView
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: contentMode)
                case .failure:
                    failureView
                default:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    CustomAsyncImage(
        url: URL(string:  "https://img.spoonacular.com/recipes/715415-312x231.jpg")
    )
}
