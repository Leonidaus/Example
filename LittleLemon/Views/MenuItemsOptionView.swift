import SwiftUI
import Foundation

enum SelectedCategory: CaseIterable, Identifiable {
    case food
    case drink
    case dessert

    var id: Self { self }

    var title: String {
        switch self {
        case .food: return "Food"
        case .drink: return "Drink"
        case .dessert: return "Dessert"
        }
    }
}

enum SortMenuItems: CaseIterable, Identifiable {
    case mostPopular
    case price
    case alphabet

    var id: Self { self }

    var title: String {
        switch self {
        case .mostPopular: return "Most Popular"
        case .price: return "Price $-$$$"
        case .alphabet: return "A-Z"
        }
    }
}

struct MenuItemsOptionView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: MenuViewViewModel

    var body: some View {
        NavigationStack {
            List {
                Section("Category") {
                    ForEach(SelectedCategory.allCases) { category in
                        Button(category.title) {
                            viewModel.filterCategory(category)
                        }
                    }
                }
                Section("Sort Items") {
                    ForEach(SortMenuItems.allCases) { method in
                        Button(method.title) {
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
