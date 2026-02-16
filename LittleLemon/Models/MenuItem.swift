import Foundation

struct FoodItem: Identifiable {
    let id: String
    let img: String
    let name: String
    let dsc: String
    let price: Double
    let rating: Int
    var menu: MenuCategory
}

extension FoodItem {
    init?(from dto: FoodItemDTO, category: MenuCategory) {
            // Reject empty or invalid image URLs
            guard !dto.img.isEmpty, URL(string: dto.img) != nil else { return nil }
            self.id = dto.id
            self.img = dto.img
            self.name = dto.name
            self.dsc = dto.dsc
            self.price = dto.price
            self.rating = dto.rating
            self.menu = category
        }
}
