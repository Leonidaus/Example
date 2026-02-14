//
//  LittleLemonUITests.swift
//  LittleLemonUITests
//
//  Created by Leon Haque on 28.12.2025.
//

import XCTest
@testable import LittleLemon

final class LittleLemonUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // Put helper code here
        /** Helper method for scrolling up / down from element to another  */
        private let maxScrollAttempts = 10
    private func scrollToElement(_ element: XCUIElement, in scrollView: XCUIElement, maxSwipes: Int = 5, direction: SwipeDirection = .up, shouldFail: Bool) {
            var swipeCount = 0
            while !element.isHittable && swipeCount < maxSwipes {
                switch direction {
                case .up: scrollView.swipeUp()
                case .down: scrollView.swipeDown()
                }
                swipeCount += 1
            }
        if shouldFail {
            XCTAssertFalse(element.isHittable, "Failed to scroll to \(element) after \(swipeCount) swipes")
        } else {
            XCTAssertTrue(element.isHittable, "Failed to scroll to \(element) after \(swipeCount) swipes")
        }
    }
    
    private enum SwipeDirection {
            case up, down
        }
        
    @MainActor
    func testMenuItemsView_e2e() throws {
        let app = XCUIApplication()
        app.launchEnvironment["MOCK_DATA"] = "1"
        app.launch()

        // Wait for the MenuItemsView to load (ProgressView disappears)
        let menuTitle = app.staticTexts["Menu"]
        XCTAssertTrue(menuTitle.waitForExistence(timeout: 5))

        // Wait for loading to finish
        let progress = app.progressIndicators["Fetching deliciousness"]
        if progress.exists {
            _ = progress.waitForExistence(timeout: 10)
        }
        
        let scrollView = app.scrollViews["scrollView"]
        XCTAssertTrue(scrollView.waitForExistence(timeout: 3))
        
        // Scroll until known item label is visible
        let dessertLabel = app.staticTexts["Salted Caramel Cheesecake"]
        scrollToElement(dessertLabel, in: scrollView, maxSwipes: maxScrollAttempts, direction: .up, shouldFail: false)
        
        // Verify item
        let firstItem = app.buttons["MenuItem_Salted Caramel Cheesecake"]
        XCTAssertTrue(firstItem.waitForExistence(timeout: 5))
        firstItem.tap()

        // Verify that we are on the right view
        let descriptionLabel = app.staticTexts["New York style cheesecake topped with sea salt and buttery caramel."]
        XCTAssertTrue(descriptionLabel.waitForExistence(timeout: 5))
        
        // 1️⃣ Find the slider
        let slider = app.sliders["DiscountSlider"]
        XCTAssertTrue(slider.waitForExistence(timeout: 5))

        // 2️⃣ Set slider to 50%
        slider.adjust(toNormalizedSliderPosition: 1.00)

        // 3️⃣ Check that the label updated
        let discountLabel = app.staticTexts["DiscountPercentageLabel"]
        XCTAssertTrue(discountLabel.waitForExistence(timeout: 1))
        XCTAssertNotEqual(discountLabel.label, "Discount: 0%")

        // 5️⃣ Tap the "Back" button
        let backButton = app.buttons["Back"]
        XCTAssertTrue(backButton.waitForExistence(timeout: 5))
        backButton.tap()

        // 6️⃣ Open the menu options sheet
        let menuButton = app.buttons["Options"]
        XCTAssertTrue(menuButton.waitForExistence(timeout: 5))
        menuButton.tap()

        // 7️⃣ Assert MenuItemsOptionView sheet appears
        let chooseCategoryButton = app.buttons["Burger"]
        XCTAssertTrue(chooseCategoryButton.waitForExistence(timeout: 5))
        chooseCategoryButton.tap()
        
        // Confirm that sheet is gone
        let doneButton = app.buttons["Done"]
        XCTAssertTrue(doneButton.waitForExistence(timeout: 5))
        doneButton.tap()
        XCTAssertFalse(doneButton.waitForExistence(timeout: 5))
        
        // Scroll up until burger item is found (should fail)
        let burgerLabel = app.staticTexts["Truffle Zest Pasta"]
        scrollToElement(burgerLabel, in: scrollView, maxSwipes: maxScrollAttempts, direction: .down, shouldFail: true)
    }
}
