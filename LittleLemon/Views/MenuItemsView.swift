import SwiftUI

struct MenuItemsView: View {

    @State private var showMenuOptions: Bool = false
    @StateObject private var viewModel: MenuViewViewModel
    @State private var selectedItem: FoodItem?

    init(viewModel: MenuViewViewModel = MenuViewViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 0) {
            // Custom nav bar at the top
            CustomNavBar(title: "Menu") {
                showMenuOptions = true
            }
            .background(Color.blue)
            .accessibilityIdentifier("CustomNavBar")
            
            // Main content
            NavigationStack {
                ScrollView {
                    LazyVStack {
                        if viewModel.isLoading {
                            ProgressView("Fetching deliciousness")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding()
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
                .accessibilityIdentifier("scrollView")
            }
            .sheet(item: $selectedItem) { item in
                NavigationStack {
                    MenuItemDetailsView(item: item)
                        .navigationTitle(item.name)
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                Button("Back") { selectedItem = nil }
                            }
                        }
                }
            }
        }
        .sheet(isPresented: $showMenuOptions) {
            MenuItemsOptionView(viewModel: viewModel)
        }
        .task {
            await viewModel.loadApiData()
        }
    }
}
