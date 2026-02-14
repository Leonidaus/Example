import SwiftUI

struct MenuItemDetailsView: View {
    
    let item: FoodItem

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
                    Text(String(format: "%.2f", item.price))

                    Text("Rating:")
                        .font(.headline)
                    Text("\(item.rating)")

                    Text("Description:")
                        .font(.headline)
                    Text(item.dsc)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            }
        }
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
