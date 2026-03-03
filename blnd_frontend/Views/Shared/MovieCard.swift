import SwiftUI

struct MovieCard: View {
    var title: String? = nil
    var year: String? = nil
    var width: CGFloat = 90
    var height: CGFloat = 130
    var glow: Bool = false
    var gradientAngle: Int = 135

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(AppTheme.posterGradient(angle: gradientAngle))
                    .frame(width: width, height: height)
                    .shadow(color: glow ? .white.opacity(0.13) : .clear, radius: glow ? 12 : 0)

                // Bottom gradient overlay
                LinearGradient(
                    colors: [.clear, .black.opacity(0.5)],
                    startPoint: .center,
                    endPoint: .bottom
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .frame(width: width, height: height)
            }

            if let title {
                Text(title)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .frame(width: width, alignment: .leading)
            }

            if let year {
                Text(year)
                    .font(.system(size: 10))
                    .foregroundStyle(AppTheme.textMuted)
            }
        }
    }
}

#Preview {
    HStack(spacing: 10) {
        MovieCard(title: "Dune", year: "2021")
        MovieCard(title: "Arrival", year: "2016", glow: true)
        MovieCard()
    }
    .padding()
    .background(AppTheme.background)
}
