import Foundation
import Combine

class MenuViewViewModel: ObservableObject {

    @Published var burgerMenuItems: [FoodItem] = []
    @Published var drinkMenuItems: [FoodItem] = []
    @Published var dessertMenuItems: [FoodItem] = []
    @Published var selectedCategories: Set<SelectedCategory> = [.burgers, .drinks, .desserts]
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let networkManager: NetworkManaging
    private var useMockData: Bool {
        #if DEBUG
        return ProcessInfo.processInfo.environment["MOCK_DATA"] == "1"
        #else
        return false
        #endif
    }
    
    // Accept protocol in initializer
    init(networkManager: NetworkManaging = NetworkManager.shared) {
        self.networkManager = networkManager
        if self.useMockData {
            loadMockData()
        }
    }

    func loadApiData() async {
        guard !useMockData else { return }
        
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        do {
            async let burgersDTO = networkManager.fetchMenu(category: "burgers")
            async let drinksDTO = networkManager.fetchMenu(category: "drinks")
            async let dessertsDTO = networkManager.fetchMenu(category: "desserts")
            
            let (burgers, drinks, desserts) = try await (burgersDTO, drinksDTO, dessertsDTO)
            
            await MainActor.run {
                self.burgerMenuItems = burgers.compactMap { FoodItem(from: $0, category: .burgers) }
                self.drinkMenuItems = drinks.compactMap { FoodItem(from: $0, category: .drinks) }
                self.dessertMenuItems = desserts.compactMap { FoodItem(from: $0, category: .desserts) }
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
    
    //MARK: 
    
    var isBurgersSelected: Bool {
        selectedCategories.contains(.burgers)
    }
    var isDrinksSelected: Bool {
        selectedCategories.contains(.drinks)
    }
    var isDessertsSelected: Bool {
        selectedCategories.contains(.desserts)
    }

    func sortItems(by method: SortMenuItems) {
        let sortClosure: (FoodItem, FoodItem) -> Bool
        
        switch method {
        case .mostPopular:
            sortClosure = { $0.rating > $1.rating }
        case .price:
            sortClosure = { $0.price < $1.price }
        case .alphabet:
            sortClosure = { $0.name < $1.name }
        }
        
        burgerMenuItems.sort(by: sortClosure)
        drinkMenuItems.sort(by: sortClosure)
        dessertMenuItems.sort(by: sortClosure)
    }

    func toggleCategory(_ category: SelectedCategory) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }

}
