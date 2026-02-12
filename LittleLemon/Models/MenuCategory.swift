enum MenuCategory: String {
    case food
    case drink
    case dessert

    var title: String {
        switch self {
        case .food:
            return "Food"
        case .drink:
            return "Drink"
        case .dessert:
            return "Dessert"
        }
    }
}
