import SwiftUI
import Foundation

struct Item: View {
    let name: String
    let img: String

    var body: some View {
        VStack(spacing: 8) {
            CachedAsyncImage(url: URL(string: img)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 160, height: 120)
                        .background(Color.gray.opacity(0.1))
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 160, height: 120)
                        .clipped()
                case .failure:
                    Image("Image")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 160, height: 120)
                        .clipped()
                @unknown default:
                    EmptyView()
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Text(name)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(2) // Prevent overflow
        }
        .padding()
        .frame(width: 160, height: 200)
        .background(Color.black.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
