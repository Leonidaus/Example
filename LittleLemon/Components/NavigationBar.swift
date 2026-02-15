import SwiftUI
struct CustomNavBar: View {
    var title: String
    var contentPadding: EdgeInsets = EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
    var rightButtonAction: (() -> Void)?

    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
            if let action = rightButtonAction {
                Button(action: action) {
                    Text("Options")
                        .foregroundColor(.white)
                        .imageScale(.large)
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                }
            }
        }
        .padding(contentPadding)
        .background(Color.blue)
    }
}
