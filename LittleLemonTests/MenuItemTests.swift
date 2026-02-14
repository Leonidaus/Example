import XCTest
@testable import LittleLemon

final class MenuItemTests: XCTestCase {

    func testMenuItemInitialization() {
        let fakeId = "test-123"
        let fakeName = "Test Burger"
        let fakeDescription = "A delicious test burger"
        let fakePrice = 12.99
        let fakeRating = 5
        let fakeImage = "https://example.com/image.jpg"
        
        let item = FoodItem(
            id: fakeId,
            img: fakeImage,
            name: fakeName,
            dsc: fakeDescription,
            price: fakePrice,
            rating: fakeRating,
            menu: .burgers
        )
        
        XCTAssertEqual(item.id, fakeId)
        XCTAssertEqual(item.name, fakeName)
        XCTAssertEqual(item.dsc, fakeDescription)
        XCTAssertEqual(item.price, fakePrice)
        XCTAssertEqual(item.rating, fakeRating)
        XCTAssertEqual(item.menu, .burgers)
    }
    
    func testFoodItemFromDTO() {
        let dto = FoodItemDTO(
            id: "test-123",
            img: "https://example.com/image.jpg",
            name: "Test Burger",
            dsc: "A delicious test burger",
            price: 12.99,
            rating: 5
        )
        
        let item = FoodItem(from: dto, category: .burgers)
        
        XCTAssertEqual(item.id, dto.id)
        XCTAssertEqual(item.name, dto.name)
        XCTAssertEqual(item.dsc, dto.dsc)
        XCTAssertEqual(item.price, dto.price)
        XCTAssertEqual(item.rating, dto.rating)
        XCTAssertEqual(item.menu, .burgers)
    }

}
