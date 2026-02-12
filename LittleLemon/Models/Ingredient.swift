import Foundation

enum Ingredient: String {
    case spinach = "Spinach"
    case broccoli = "Broccoli"
    case carrot = "Carrot"
    case pasta = "Pasta"
    case tomato = "Tomato Sauce"

    var title: String {
        switch self {
        case .spinach: return "Spinach"
        case .broccoli: return "Broccoli"
        case .carrot: return "Carrot"
        case .pasta: return "Pasta"
        case .tomato: return "Tomato Sauce"
        }
    }
}
