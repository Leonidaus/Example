import SwiftUI
import Foundation

enum SelectedCategory: String, CaseIterable, Identifiable {
    case Food = "Food"
    case Drink = "Drink"
    case Dessert = "Dessert"
    
    var id: String {self.rawValue}
}

enum SortMenuItems: String, CaseIterable, Identifiable {
    case MostPopular = "Most Popular"
    case Price = "Price $-$$$"
    case Alphabet = "A-Z"
    
    var id: String {self.rawValue}
}

struct MenuItemsOptionView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: MenuViewViewModel

    var body: some View {
        NavigationStack {
            List {
                Section("Category") {
                    ForEach(SelectedCategory.allCases) { category in
                        Button(category.rawValue) {
                            viewModel.filterCategory(category)
                        }
                    }
                }
                Section("Sort Items") {
                    ForEach(SortMenuItems.allCases) { method in
                        Button(method.rawValue) {
                            viewModel.sortItems(by: method)
                        }
                    }
                }
            }
            .navigationTitle("Menu Options")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}
