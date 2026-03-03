import SwiftUI

struct GenrePill: View {
    let label: String
    var isActive: Bool = false
    var isSmall: Bool = false
    var action: (() -> Void)? = nil

    var body: some View {
        if let action {
            Button(action: action) { content }
        } else {
            content
        }
    }

    private var content: some View {
        Text(label)
            .font(.system(size: isSmall ? 12 : 14, weight: .medium))
            .padding(.vertical, isSmall ? 6 : 10)
            .padding(.horizontal, isSmall ? 12 : 18)
            .background(isActive ? .white : AppTheme.card)
            .foregroundStyle(isActive ? .black : AppTheme.textMuted)
            .clipShape(Capsule())
    }
}

#Preview {
    HStack {
        GenrePill(label: "Action", isActive: true)
        GenrePill(label: "Comedy")
        GenrePill(label: "Sci-Fi", isSmall: true)
    }
    .padding()
    .background(AppTheme.background)
}
