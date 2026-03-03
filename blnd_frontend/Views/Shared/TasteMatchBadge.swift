import SwiftUI

struct TasteMatchBadge: View {
    let percentage: Int
    var size: CGFloat = 48

    var body: some View {
        ZStack {
            Circle()
                .stroke(AppTheme.border, lineWidth: 1.5)
                .frame(width: size, height: size)

            Text("\(percentage)%")
                .font(.system(size: size * 0.25, weight: .semibold))
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    HStack {
        TasteMatchBadge(percentage: 87)
        TasteMatchBadge(percentage: 92, size: 72)
    }
    .padding()
    .background(AppTheme.background)
}
