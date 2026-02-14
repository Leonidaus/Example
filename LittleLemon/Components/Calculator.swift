import SwiftUI

struct CalculatorView: View {
    
    let value: Double?
    
    @State private var discountPercentage: Double = 0
    
    var discountedAmount: Double {
        guard let priceValue = value else { return 0 }
        return priceValue * (discountPercentage / 100)
    }
    
    var body: some View {
        VStack(spacing: 25) {
            
            Text("Original Price: \(value ?? 0, specifier: "%.2f")")
                .font(.headline)
            
            Text("Discount: \(discountedAmount, specifier: "%.2f")")
                .font(.largeTitle)
                .bold()
            
            VStack {
                Text("Discount: \(Int(discountPercentage))%")
                Slider(value: $discountPercentage, in: 0...100)
            }
        }
        .padding()
    }
}
