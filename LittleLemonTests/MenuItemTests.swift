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
    
    func testFoodItemFromDTO_SuccessAndFailure() throws {
        let validDTO = FoodItemDTO(
            id: "test-123",
            img: "https://example.com/image.jpg",  // valid URL
            name: "Test Burger",
            dsc: "A delicious test burger",
            price: 12.99,
            rating: 5
        )
        
        let validItem = try XCTUnwrap(FoodItem(from: validDTO, category: .burgers))
        
        XCTAssertEqual(validItem.id, validDTO.id)
        XCTAssertEqual(validItem.name, validDTO.name)
        XCTAssertEqual(validItem.dsc, validDTO.dsc)
        XCTAssertEqual(validItem.price, validDTO.price)
        XCTAssertEqual(validItem.rating, validDTO.rating)
        XCTAssertEqual(validItem.menu, .burgers)
        
        let invalidDTO1 = FoodItemDTO(id: "1", img: "", name: "No Image", dsc: "Missing image", price: 10.0, rating: 3)      // empty img
        let invalidDTO2 = FoodItemDTO(id: "2", img: "invalid_url", name: "Bad URL", dsc: "Invalid URL", price: 8.0, rating: 2)   // bad URL
        
        let item1 = FoodItem(from: invalidDTO1, category: .burgers)
        XCTAssertNil(item1, "FoodItem should be nil for invalid DTO with img: '\(invalidDTO1.img)'")
        
        let item2 = FoodItem(from: invalidDTO2, category: .burgers)
        XCTAssertNotNil(item2, "FoodItem should not be nil for invalid DTO with img: '\(invalidDTO2.img)'")
        // Intentionally let invalid pictures through
    }

}
