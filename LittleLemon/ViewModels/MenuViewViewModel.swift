import Foundation
import Combine

class MenuViewViewModel: ObservableObject {

    @Published var burgerMenuItems: [FoodItem] = []
    @Published var drinkMenuItems: [FoodItem] = []
    @Published var dessertMenuItems: [FoodItem] = []
    @Published var selectedCategories: Set<SelectedCategory> = [.burgers, .drinks, .desserts]
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let networkManager: NetworkManager
    private let useMockData: Bool
    
    init(networkManager: NetworkManager = .shared, useMockData: Bool = false) {
        self.networkManager = networkManager
        
        #if DEBUG
        if ProcessInfo.processInfo.environment["MOCK_DATA"] == "1" {
            self.useMockData = true
        } else {
            self.useMockData = useMockData
        }
        #else
        self.useMockData = useMockData
        #endif
        
        if self.useMockData {
            loadMockData()
        }
    }
    var isBurgersSelected: Bool {
        selectedCategories.contains(.burgers)
    }
    var isDrinksSelected: Bool {
        selectedCategories.contains(.drinks)
    }
    var isDessertsSelected: Bool {
        selectedCategories.contains(.desserts)
    }
    func loadApiData() async {
        guard !useMockData else { return }
        
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        do {
            async let burgersDTO = NetworkManager.shared.fetchMenu(category: "burgers")
            async let drinksDTO = NetworkManager.shared.fetchMenu(category: "drinks")
            async let dessertsDTO = NetworkManager.shared.fetchMenu(category: "desserts")
            
            let (burgers, drinks, desserts) = try await (burgersDTO, drinksDTO, dessertsDTO)
            
            await MainActor.run {
                self.burgerMenuItems = burgers.map { FoodItem(from: $0, category: .burgers) }
                self.drinkMenuItems = drinks.map { FoodItem(from: $0, category: .drinks) }
                self.dessertMenuItems = desserts.map { FoodItem(from: $0, category: .desserts) }
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "Failed to load menu data. Please try again later."
                self.isLoading = false
            }
        }
        
    }
    func loadMockData() {
        let mock = MockMenuData()
        self.burgerMenuItems = mock.burgers
        self.drinkMenuItems = mock.drinks
        self.dessertMenuItems = mock.desserts
    }

    func sortItems(by method: SortMenuItems) {
        switch method {
        case .mostPopular:
            burgerMenuItems.sort {$0.rating > $1.rating}
            drinkMenuItems.sort {$0.rating > $1.rating}
            dessertMenuItems.sort {$0.rating > $1.rating}

        case .price:
            burgerMenuItems.sort {$0.price < $1.price}
            drinkMenuItems.sort {$0.price < $1.price}
            dessertMenuItems.sort {$0.price < $1.price}

        case .alphabet:
            burgerMenuItems.sort {$0.name < $1.name}
            drinkMenuItems.sort {$0.name < $1.name}
            dessertMenuItems.sort {$0.name < $1.name}
        }
    }

    func toggleCategory(_ category: SelectedCategory) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }

}
