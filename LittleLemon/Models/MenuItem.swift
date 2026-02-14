import Foundation

struct FoodItemDTO: Codable {
    let id: String
    let img: String
    let name: String
    let dsc: String
    let price: Double
    let rating: Int
    
    enum CodingKeys: String, CodingKey {
        case id, img, name, dsc, price
        case rating = "rate"
    }
}

struct FoodItem: Identifiable {
    let id: String
    let img: String
    let name: String
    let dsc: String
    let price: Double
    let rating: Int
    var menu: MenuCategory
    
    init(id: String?, img: String?, name: String?, dsc: String?, price: Double?, rating: Int?, menu: MenuCategory) {
        self.id = id ?? ""
        self.img = img ?? ""
        self.name = name ?? ""
        self.dsc = dsc ?? ""
        self.price = price ?? 0.0
        self.rating = rating ?? 0
        self.menu = menu
    }
}

extension FoodItem {
    init(from dto: FoodItemDTO, category: MenuCategory) {
        self.id = dto.id
        self.img = dto.img
        self.name = dto.name
        self.dsc = dto.dsc
        self.price = dto.price
        self.rating = dto.rating
        self.menu = category
    }
}
