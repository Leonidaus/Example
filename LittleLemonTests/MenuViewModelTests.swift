import XCTest
@testable import LittleLemon

@MainActor
final class MenuViewViewModelTests: XCTestCase {
    var mockNetworkManager: MockNetworkManager!
    var viewModel: MenuViewViewModel!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        viewModel = MenuViewViewModel(networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        mockNetworkManager = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testLoadApiData_Success() async {
        // Given
        mockNetworkManager.mockFoodItems = [
            FoodItemDTO(id: "1", img: "https://example.com/burger.jpg", name: "Burger", dsc: "Tasty", price: 10.99, rating: 5)
        ]
        
        // When
        await viewModel.loadApiData()
        
        // Then
        XCTAssertEqual(viewModel.burgerMenuItems.count, 1)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testLoadApiData_Failure() async {
        // Given
        mockNetworkManager.shouldThrowError = true
        mockNetworkManager.errorToThrow = .invalidResponse
        
        // When
        await viewModel.loadApiData()
        
        // Then
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.burgerMenuItems.isEmpty)
    }
    
    func testSortItems_ByPrice() async {
        // Given
        viewModel.burgerMenuItems = [
            FoodItem(id: "1", img: "", name: "Expensive", dsc: "", price: 20.0, rating: 5, menu: .burgers),
            FoodItem(id: "2", img: "", name: "Cheap", dsc: "", price: 5.0, rating: 4, menu: .burgers)
        ]
        
        // When
        viewModel.sortItems(by: .price)
        
        // Then
        XCTAssertEqual(viewModel.burgerMenuItems.first?.name, "Cheap")
        XCTAssertEqual(viewModel.burgerMenuItems.last?.name, "Expensive")
    }
    
    func testToggleCategory_AddsAndRemoves() async {
        // Given
        viewModel.selectedCategories = [.burgers]
        
        // When - Remove
        viewModel.toggleCategory(.burgers)
        
        // Then
        XCTAssertFalse(viewModel.selectedCategories.contains(.burgers))
        
        // When - Add back
        viewModel.toggleCategory(.burgers)
        
        // Then
        XCTAssertTrue(viewModel.selectedCategories.contains(.burgers))
    }
}
