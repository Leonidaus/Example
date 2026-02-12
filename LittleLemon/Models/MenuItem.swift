import Foundation

struct MenuItem: Identifiable, MenuItemProtocol, Hashable {
    let id = UUID()
    let price: Double
    let title: String
    var menu: MenuCategory
    var orderCount: Int
    var price2: Int
    var ingredients: [Ingredient]
    
    init(title: String, menu: MenuCategory, price: Double, orderCount: Int = 0, price2: Int = 0, ingredients: [Ingredient] = []) {
        self.title = title
        self.menu = menu
        self.price = price
        self.orderCount = orderCount
        self.price2 = price2
        self.ingredients = ingredients
    }
}
