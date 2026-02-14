import SwiftUI

struct CustomNavBar: View {
    var title: String
    var contentPadding: EdgeInsets = EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
    var rightButtonAction: (() -> Void)?

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
