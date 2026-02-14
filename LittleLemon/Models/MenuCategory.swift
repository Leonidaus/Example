enum MenuCategory: String {
    case burgers
    case drinks
    case desserts

    var title: String {
        switch self {
        case .burgers:
            return "Burgers"
        case .drinks:
            return "Drinks"
        case .desserts:
            return "Desserts"
        }
    }
}
