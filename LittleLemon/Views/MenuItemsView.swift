import SwiftUI

struct MenuItemsView: View {
    
    @State private var showMenuOptions: Bool = false
    
    @StateObject private var viewModel: MenuViewViewModel
    
    @State private var selectedItem: MenuItem?



    var category: MenuCategory

    init(category: MenuCategory, viewModel: MenuViewViewModel = MenuViewViewModel()) {
        self.category = category
        _viewModel = StateObject(wrappedValue: viewModel)
    }


    var items: [MenuItem] {
        switch category {
        case .food: return viewModel.foodMenuItems
        case .drink: return viewModel.drinkMenuItems
        case .dessert: return viewModel.dessertMenuItems
        }
    }
        
    var body: some View {

        let navBarHeight: CGFloat = 0

        ZStack(alignment: .top) {
            
            NavigationStack {

                List {
                    if viewModel.selectedCategories.contains(.Food) {
                        VStack {
                            Text("Food")
                            GridView(
                                items: viewModel.foodMenuItems,
                                columns: [GridItem(.flexible()), GridItem(.flexible())]
                            ) { item in
                                Button {
                                    selectedItem = item
                                } label: {
                                    Item(title: item.title)
                                }
                                .buttonStyle(.plain)
                            }

                        }.listRowSeparator(.hidden)
                    }
                        if viewModel.selectedCategories.contains(.Drink) {
                        VStack {
                            Text("Drinks")
                            GridView(items: viewModel.drinkMenuItems,
                                     columns: [GridItem(.flexible()), GridItem(.flexible())]) { item in
                                Button {
                                    selectedItem = item
                                } label: {
                                    Item(title: item.title)
                                }
                                .buttonStyle(.plain)
                            }
                        }.listRowSeparator(.hidden)
                    }
                    if viewModel.selectedCategories.contains(.Dessert) {
                        VStack {
                            Text("Desserts")
                            GridView(items: viewModel.dessertMenuItems,
                                     columns: [GridItem(.flexible()), GridItem(.flexible())]) { item in
                                Button {
                                    selectedItem = item
                                } label: {
                                    Item(title: item.title)
                                }
                                .buttonStyle(.plain)
                            }
                        }.listRowSeparator(.hidden)
                    }
                }
                .navigationTitle("Menu")
                .listStyle(.plain)
                .padding(.top, navBarHeight)

            }.sheet(item: $selectedItem) { item in
                NavigationStack {
                    MenuItemDetailsView(
                        title: item.title,
                        price: item.price,
                        orderCount: item.orderCount,
                        ingredients: item.ingredients
                    )
                    .navigationTitle(item.title)
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
        
        .ignoresSafeArea(edges: .top)
    }
}

