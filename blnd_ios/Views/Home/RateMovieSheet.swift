import SwiftUI

struct RateMovieSheet: View {
    let title: String
    let year: String

    @Environment(\.dismiss) private var dismiss
    @State private var rating: Int = 4
    @State private var note = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Movie info row
            HStack(spacing: 14) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(AppTheme.posterGradient)
                    .frame(width: 44, height: 62)

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white)
                    Text(year)
                        .font(.system(size: 13))
                        .foregroundStyle(AppTheme.textMuted)
                }

                Spacer()
            }
            .padding(.bottom, 20)

            // Star rating
            HStack(spacing: 12) {
                ForEach(0 ..< 5, id: \.self) { index in
                    Button {
                        rating = index + 1
                    } label: {
                        Image(systemName: "star.fill")
                            .font(.system(size: 28))
                            .foregroundStyle(index < rating ? .white : AppTheme.border)
                    }
                }
            }
            .padding(.bottom, 16)

            // Note field
            TextField("Add a note...", text: $note, axis: .vertical)
                .font(.system(size: 14))
                .foregroundStyle(.white)
                .padding(14)
                .background(Color(hex: 0x111111))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .lineLimit(3 ... 5)
                .padding(.bottom, 16)

            AppButton(label: "Save") {
                dismiss()
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .padding(.bottom, 32)
    }
}

#Preview {
    RateMovieSheet(title: "Oppenheimer", year: "2023")
        .background(AppTheme.card)
}
