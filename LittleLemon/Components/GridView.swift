import SwiftUI

struct GridView<Item: Identifiable, Content: View>: View {
    let items: [Item]
    let columns: [GridItem]
    var spacing: CGFloat = 12
    @ViewBuilder let content: (Item) -> Content

    var body: some View {
        LazyVGrid(columns: columns, spacing: spacing) {
            ForEach(items) { item in
                content(item)
            }
        }
    }
}
