import Foundation

struct MockMenuData {

    let food: [MenuItem] = [
        MenuItem(title: "Pizza", menu: .food, price: 12.99, orderCount: 2, price2: 13, ingredients: [Ingredient.broccoli]),
        MenuItem(title: "Pasta", menu: .food, price: 10.49, orderCount: 0, price2: 10, ingredients: []),
        MenuItem(title: "Burger", menu: .food, price: 9.99, orderCount: 0, price2: 10, ingredients: []),
        MenuItem(title: "Steak", menu: .food, price: 18.99, orderCount: 0, price2: 19, ingredients: []),
        MenuItem(title: "Mashed Potatoes", menu: .food, price: 5.99, orderCount: 0, price2: 6, ingredients: []),
        MenuItem(title: "Tacos", menu: .food, price: 8.49, orderCount: 0, price2: 8, ingredients: []),
        MenuItem(title: "Fried Chicken", menu: .food, price: 11.99, orderCount: 0, price2: 12, ingredients: []),
        MenuItem(title: "Lasagna", menu: .food, price: 13.99, orderCount: 1, price2: 14, ingredients: []),
        MenuItem(title: "Salmon", menu: .food, price: 15.49, orderCount: 0, price2: 15, ingredients: []),
        MenuItem(title: "Grilled Cheese", menu: .food, price: 6.99, orderCount: 0, price2: 7, ingredients: []),
        MenuItem(title: "Chicken Alfredo", menu: .food, price: 12.49, orderCount: 0, price2: 12, ingredients: []),
        MenuItem(title: "Caesar Salad", menu: .food, price: 7.99, orderCount: 0, price2: 8, ingredients: [])
    ]

    let drink: [MenuItem] = [
        MenuItem(title: "Water", menu: .drink, price: 1.99, orderCount: 0, price2: 2, ingredients: []),
        MenuItem(title: "Milk", menu: .drink, price: 2.49, orderCount: 2, price2: 2, ingredients: []),
        MenuItem(title: "Coffee", menu: .drink, price: 3.49, orderCount: 0, price2: 3, ingredients: []),
        MenuItem(title: "Tea", menu: .drink, price: 2.99, orderCount: 0, price2: 3, ingredients: []),
        MenuItem(title: "Orange Juice", menu: .drink, price: 3.99, orderCount: 0, price2: 4, ingredients: []),
        MenuItem(title: "Lemonade", menu: .drink, price: 2.99, orderCount: 0, price2: 3, ingredients: []),
        MenuItem(title: "Smoothie", menu: .drink, price: 4.99, orderCount: 1, price2: 5, ingredients: []),
        MenuItem(title: "Soda", menu: .drink, price: 1.99, orderCount: 0, price2: 2, ingredients: [])
    ]

    let dessert: [MenuItem] = [
        MenuItem(title: "Chocolate Cake", menu: .dessert, price: 4.99, orderCount: 0, price2: 5, ingredients: []),
        MenuItem(title: "Ice Cream", menu: .dessert, price: 3.99, orderCount: 2, price2: 4, ingredients: []),
        MenuItem(title: "Brownie", menu: .dessert, price: 2.99, orderCount: 0, price2: 3, ingredients: []),
        MenuItem(title: "Cheesecake", menu: .dessert, price: 5.49, orderCount: 1, price2: 5, ingredients: [])
    ]
}
