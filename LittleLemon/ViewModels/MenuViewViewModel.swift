import Foundation
import Combine


class MenuViewViewModel: ObservableObject {
    
    @Published var foodMenuItems: [MenuItem]
    @Published var drinkMenuItems: [MenuItem]
    @Published var dessertMenuItems: [MenuItem]
    
    
    @Published var selectedCategories: Set<SelectedCategory> = [.Food, .Drink, .Dessert]

    
    
    @Published var isFoodSelected: Bool = true
    @Published var isDrinkSelected: Bool = true
    @Published var isDessertSelected: Bool = true
    
    
    
    init() {
        let mock = MockMenuData()
        self.foodMenuItems = mock.food
        self.drinkMenuItems = mock.drink
        self.dessertMenuItems = mock.dessert
    }
    
    func sortItems(by method: SortMenuItems) {
        switch method {
        case .MostPopular:
            foodMenuItems.sort {$0.orderCount > $1.orderCount}
            drinkMenuItems.sort {$0.orderCount > $1.orderCount}
            dessertMenuItems.sort {$0.orderCount > $1.orderCount}
            
        case .Price:
            foodMenuItems.sort {$0.price < $1.price}
            drinkMenuItems.sort {$0.price < $1.price}
            dessertMenuItems.sort {$0.price < $1.price}
            
        case .Alphabet:
            foodMenuItems.sort {$0.title < $1.title}
            drinkMenuItems.sort {$0.title < $1.title}
            dessertMenuItems.sort {$0.title < $1.title}
        }
    }
    
    
    // this functionality does not even work.
    func filterCategory(_ category: SelectedCategory) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }


}
