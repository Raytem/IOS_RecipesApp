//
//  MainView.swift
//  RecipeBook
//
//  Created by Daniil on 5.01.25.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @State private var searchTerm = ""
    @State private var isSortConfirmationDialogShowing = false
    @State private var orderBy: Int = 1
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Screens.Main.RecipesTitle")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color(uiColor: .primary100), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .searchable(text: $searchTerm, placement: .toolbar)
            .toolbar {
                ToolbarItemGroup {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                    
                    Button(action: {
                        isSortConfirmationDialogShowing.toggle()
                    }) {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                    }
                    .confirmationDialog("Select a color", isPresented: $isSortConfirmationDialogShowing, titleVisibility: .visible) {
                        Button("Red") {
                            orderBy = 1
                        }

                        Button("Green") {
                            orderBy = 2
                        }

                        Button("Blue") {
                            orderBy = 3
                        }
                    }
                }
            }
        }
        .tint(Color(uiColor: .neaturalBlack))
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    MainView()
        .modelContainer(for: Item.self, inMemory: true)
}
