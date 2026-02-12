import XCTest
@testable import LittleLemon

final class MenuItemTests: XCTestCase {

    func testMenuItemTitleInitialization() {
        let fakeTitle = "Fake Title"
        let item = MenuItem(title: fakeTitle,
                            menu: .food,
                            price: 12.99,
                            orderCount: 2,
                            price2: 13,
                            ingredients: [Ingredient.broccoli])
        XCTAssertEqual(item.title, fakeTitle)
    }

    func testMenuItemIngredientInitialization() {
        let fakeIngredients: [Ingredient] = [.broccoli, .carrot]
        let item = MenuItem(
            title: "Veggie Salad",
            menu: .food,
            price: 8.99,
            orderCount: 0,
            price2: 9,
            ingredients: fakeIngredients
        )
        XCTAssertEqual(fakeIngredients, item.ingredients)
    }

}
