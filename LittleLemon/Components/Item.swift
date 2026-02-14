import SwiftUI
import Foundation

struct Item: View {
    let name: String
    let img: String

    var body: some View {
        VStack(spacing: 8) {
            AsyncImage(url: URL(string: img)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(height: 120)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 120)
                                    .clipped()
                            case .failure:
                                Image("Image")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(height: 120)
                                        .clipped()

                            @unknown default:
                                EmptyView()
                            }
                        }
                        .cornerRadius(10)
            Text(name)
                .font(.headline)
                .foregroundColor(.primary)
        }
        .padding()
        .background(Color.black.opacity(0.05))
        .cornerRadius(12)
    }
}
