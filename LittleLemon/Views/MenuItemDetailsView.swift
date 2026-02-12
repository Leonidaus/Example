import SwiftUI

struct MenuItemDetailsView: View {

    let title: String
    let price: Double
    let orderCount: Int
    let ingredients: [Ingredient]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                Image("Image")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .padding()

                Divider()

                VStack(alignment: .leading, spacing: 12) {

                    Text("Price:")
                        .font(.headline)
                    Text(String(format: "%.2f", price))

                    Text("Ordered:")
                        .font(.headline)
                    Text("\(orderCount)")

                    Text("Ingredients:")
                        .font(.headline)

                    VStack(alignment: .leading) {
                        ForEach(ingredients, id: \.self) { ingredient in
                            Text(ingredient.rawValue)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
