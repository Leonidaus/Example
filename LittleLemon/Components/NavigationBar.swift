import SwiftUI

// MARK: - Custom Navigation Bar Component
struct CustomNavBar: View {
    var title: String
    var contentPadding: EdgeInsets = EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
    var rightButtonAction: (() -> Void)? = nil

    init(title: String, contentPadding: EdgeInsets, rightButtonAction: (() -> Void)? = nil) {
        self.title = title
        self.contentPadding = contentPadding
        self.rightButtonAction = rightButtonAction
    }

    init(title: String, horizontal: CGFloat = 16, vertical: CGFloat = 12, rightButtonAction: (() -> Void)? = nil) {
        self.title = title
        self.contentPadding = EdgeInsets(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
        self.rightButtonAction = rightButtonAction
    }

    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
            if let action = rightButtonAction {
                Button(action: action) {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                }
            }
        }
        .padding(contentPadding)
        .background(Color.blue)
    }
}

// MARK: - Sample Screen to Simulate Navbar
struct SampleScreen: View {
    var body: some View {
        VStack(spacing: 0) {
            // Use the custom navbar here
            CustomNavBar(title: "Home", horizontal: 30, vertical: 44) {
                print("Right button tapped!")
            }
            Divider() // Optional: visual separation
            Spacer()
            Text("This is the main content area")
                .font(.title2)
                .foregroundColor(.gray)
            Spacer()
        }
        .edgesIgnoringSafeArea(.top) // Makes navbar appear at the top
    }
}

// MARK: - Preview / Simulation in Code
struct SampleScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SampleScreen()
                .previewDisplayName("Light Mode")
                .preferredColorScheme(.light)

            SampleScreen()
                .previewDisplayName("Dark Mode")
                .preferredColorScheme(.dark)
        }
    }
}
