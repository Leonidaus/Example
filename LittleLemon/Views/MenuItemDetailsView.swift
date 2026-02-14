import SwiftUI

struct MenuItemDetailsView: View {
    
    let item: FoodItem

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                Image("Image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                Divider()
                VStack(alignment: .leading, spacing: 12) {

                    CalculatorView(value: item.price)

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
