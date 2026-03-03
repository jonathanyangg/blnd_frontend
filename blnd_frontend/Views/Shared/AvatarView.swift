import SwiftUI

struct AvatarView: View {
    var size: CGFloat = 40
    var overlap: Bool = false

    var body: some View {
        Circle()
            .fill(AppTheme.avatarGradient)
            .frame(width: size, height: size)
            .overlay(
                Circle()
                    .stroke(AppTheme.background, lineWidth: 2)
            )
            .padding(.leading, overlap ? -10 : 0)
    }
}

#Preview {
    HStack(spacing: 0) {
        AvatarView()
        AvatarView(overlap: true)
        AvatarView(overlap: true)
    }
    .padding()
    .background(AppTheme.background)
}
