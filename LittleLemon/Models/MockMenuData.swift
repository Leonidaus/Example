import Foundation

struct MockMenuData {

    let burgers: [FoodItem] = [
        FoodItem(id: "food1", img: "https://loremflickr.com/320/240/food", name: "Truffle Zest Pasta", dsc: "Hand-rolled pappardelle in a creamy mushroom reduction.", price: 18.5, rating: 5, menu: .burgers),

        FoodItem(id: "food2", img: "https://loremflickr.com/320/240/food", name: "Spicy Miso Ramen", dsc: "Rich pork broth with bamboo shoots and a marinated egg.", price: 14.0, rating: 4, menu: .burgers),

        FoodItem(id: "food3", img: "https://loremflickr.com/320/240/food", name: "Artisan Wagyu Burger", dsc: "Double-stacked beef with caramelized onions and gruyère.", price: 22.0, rating: 5, menu: .burgers),

        FoodItem(id: "food4", img: "https://loremflickr.com/320/240/food", name: "Garden Harvest Salad", dsc: "Seasonal greens, roasted beets, and a lemon-tahini dressing.", price: 12.5, rating: 3, menu: .burgers),

        FoodItem(id: "food5", img: "https://loremflickr.com/320/240/food", name: "Crispy Peking Duck", dsc: "Traditional slow-roasted duck served with hoisin and pancakes.", price: 34.9, rating: 5, menu: .burgers),

        FoodItem(id: "food6", img: "https://loremflickr.com/320/240/food", name: "Golden Turmeric Bowl", dsc: "Quinoa base topped with chickpeas and roasted cauliflower.", price: 15.75, rating: 4, menu: .burgers),

        FoodItem(id: "food7", img: "https://loremflickr.com/320/240/food", name: "Smoked Salmon Bagel", dsc: "Everything bagel with capers, red onion, and dill cream cheese.", price: 11.2, rating: 4, menu: .burgers),

        FoodItem(id: "food8", img: "https://loremflickr.com/320/240/food", name: "Neapolitan Margherita", dsc: "San Marzano tomatoes, fresh mozzarella, and basil leaves.", price: 16.5, rating: 5, menu: .burgers)
    ]

    let drinks: [FoodItem] = [
        FoodItem(id: "drink1", img: "https://loremflickr.com/320/240/food", name: "Midnight Espresso Martini", dsc: "Cold brew concentrate shaken with organic vanilla bean syrup.", price: 13.5, rating: 5, menu: .drinks),

        FoodItem(id: "drink2", img: "https://loremflickr.com/320/240/food", name: "Hibiscus Ginger Fizz", dsc: "Sparkling botanical tea infused with fresh ginger and lime zest.", price: 7.0, rating: 4, menu: .drinks),

        FoodItem(id: "drink3", img: "https://loremflickr.com/320/240/food", name: "Velvet Matcha Latte", dsc: "Ceremonial grade matcha whisked with creamy oat milk and honey.", price: 6.5, rating: 5, menu: .drinks),

        FoodItem(id: "drink4", img: "https://loremflickr.com/320/240/food", name: "Spiced Blood Orange Soda", dsc: "Hand-crafted soda with star anise and squeezed blood oranges.", price: 5.5, rating: 4, menu: .drinks)
    ]

    let desserts: [FoodItem] = [
        FoodItem(id: "dessert1", img: "https://loremflickr.com/320/240/food", name: "Molten Lava Cake", dsc: "Dark chocolate ganache center served with Madagascar vanilla bean gelato.", price: 9.5, rating: 5, menu: .desserts),

        FoodItem(id: "dessert2", img: "https://loremflickr.com/320/240/food", name: "Sicilian Lemon Tart", dsc: "Shortbread crust with zesty lemon curd and toasted Italian meringue.", price: 8.0, rating: 4, menu: .desserts),

        FoodItem(id: "dessert3", img: "https://loremflickr.com/320/240/food", name: "Salted Caramel Cheesecake", dsc: "New York style cheesecake topped with sea salt and buttery caramel.", price: 10.5, rating: 5, menu: .desserts),

        FoodItem(id: "dessert4", img: "https://loremflickr.com/320/240/food", name: "Matcha Tiramisu", dsc: "Ladyfingers soaked in green tea with light mascarpone cream layers.", price: 9.0, rating: 4, menu: .desserts)
    ]
}
