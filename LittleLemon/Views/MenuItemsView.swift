import SwiftUI

struct MenuItemsView: View {

    @State private var showMenuOptions: Bool = false

    @StateObject private var viewModel: MenuViewViewModel

    @State private var selectedItem: FoodItem?

    var category: MenuCategory

    init(category: MenuCategory, viewModel: MenuViewViewModel = MenuViewViewModel()) {
        self.category = category
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var items: [FoodItem] {
        switch category {
        case .burgers: return viewModel.burgerMenuItems
        case .drinks: return viewModel.drinkMenuItems
        case .desserts: return viewModel.dessertMenuItems
        }
    }

    var body: some View {

        let navBarHeight: CGFloat = 0

        ZStack(alignment: .top) {
            NavigationStack {
                ScrollView {
                    LazyVStack {
                        if viewModel.isLoading {
                            ProgressView("Fetching deliciousness")
                        } else if let error = viewModel.errorMessage {
                            Text("\(error) is the only thing keeping you away from sweets")
                        } else {
                            if viewModel.selectedCategories.contains(.burgers) {
                                CategorySection(title: "Burger", items: viewModel.burgerMenuItems) { selectedItem = $0 }
                            }
                            if viewModel.selectedCategories.contains(.drinks) {
                                CategorySection(title: "Drinks", items: viewModel.drinkMenuItems) { selectedItem = $0}
                            }
                            if viewModel.selectedCategories.contains(.desserts) {
                                CategorySection(title: "Desserts", items: viewModel.dessertMenuItems) { selectedItem = $0}
                            }
                        }
                    }
                }
                .navigationTitle("Menu")
                .listStyle(.plain)
                .padding(.top, navBarHeight)

            }
            .sheet(item: $selectedItem) { item in
                NavigationStack {
                    MenuItemDetailsView(item: item
                    )
                    .navigationTitle(item.name)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("Back") { selectedItem = nil }
                        }
                    }
                }
            }

            CustomNavBar(title: "Menu", horizontal: 60, vertical: 46) {
                showMenuOptions = true
            }
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .zIndex(1)
            .sheet(isPresented: $showMenuOptions) {
                MenuItemsOptionView(viewModel: viewModel)
            }

        }
        .task {
            await viewModel.loadApiData()
        }
        .ignoresSafeArea(edges: .top)
    }
}
