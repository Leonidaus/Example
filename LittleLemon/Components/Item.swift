import SwiftUI
import Foundation

struct Item: View {
    let title: String

    var imageURL: URL? {
            let keyword = title
                    .lowercased()
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                    .replacingOccurrences(of: " ", with: ",")
            let encoded = keyword.addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed
            )
            return URL(string: "https://loremflickr.com/320/240/\(encoded ?? "food")")
        }

    var body: some View {
        VStack(spacing: 8) {

            // Top container (could be image or placeholder)
            AsyncImage(url: imageURL) { phase in
                            switch phase {
                            case .empty:
                                // Loading placeholder
                                ProgressView()
                                    .frame(height: 120)

                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 120)
                                    .clipped()

                            case .failure:
                                // Fallback if loading fails
                                Color.gray
                                    .frame(height: 120)

                            @unknown default:
                                EmptyView()
                            }
                        }
                        .cornerRadius(10)
            // Title underneath
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
        }
        .padding()
        .background(Color.black.opacity(0.05))
        .cornerRadius(12)
    }
}

#Preview("Light Mode") {
    Item(title: "food")
            .preferredColorScheme(.light)
}

/**
 
 import Foundation

 struct MenuItem: Identifiable, MenuItemProtocol {
     let id = UUID()
     let price: Double
     let title: String
     var menu: MenuCategory
     var orderCount: Int
     var price2: Int
     var ingredients: [Ingredient]

     init(title: String, menu: MenuCategory, price: Double, orderCount: Int = 0, price2: Int = 0, ingredients: [Ingredient] = []) {
         self.title = title
         self.menu = menu
         self.price = price
         self.orderCount = orderCount
         self.price2 = price2
         self.ingredients = ingredients
     }
 }
*/
