import Foundation

protocol MenuItemProtocol {
    var id: UUID { get }
    var price: Double { get }
    var title: String { get }
    var menu: MenuCategory { get }
    var orderCount: Int { get set }
    var price2: Int { get set }
    var ingredients: [Ingredient] { get set }
}
