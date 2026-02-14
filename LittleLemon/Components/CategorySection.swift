//
//  CategorySection.swift
//  LittleLemon
//
//  Created by Leon Haque on 14.2.2026.
//
import SwiftUI

struct CategorySection: View {
    let title: String
    let items: [FoodItem]
    let onItemTap: (FoodItem) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            Text(title)
                .font(.title2.bold())
                .padding(.horizontal)

            GridView(
                items: items,
                columns: [GridItem(.flexible(), spacing: 16),
                          GridItem(.flexible(), spacing: 16)]
            ) { item in
                Button {
                    onItemTap(item)
                } label: {
                    // This is your custom 'Item' view
                    Item(name: item.name, img: item.img)
                }
                .buttonStyle(.plain)
                .accessibilityIdentifier("MenuItem_\(item.name)")
            }
            .padding(.horizontal)
        }
        .padding(.bottom, 20)
    }
}
