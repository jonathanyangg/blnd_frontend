import SwiftUI

struct PickGenresView: View {
    private let allGenres = [
        "Action", "Comedy", "Horror", "Sci-Fi", "Romance", "Thriller",
        "Drama", "Animation", "Documentary", "Mystery", "Fantasy", "Crime",
    ]

    @State private var selectedGenres: Set<String> = []
    @State private var navigateToRate = false

    private var canContinue: Bool {
        selectedGenres.count >= 3
    }

    var body: some View {
        VStack(spacing: 0) {
            OnboardingProgressBar(step: 2, total: 4)
                .padding(.top, 12)

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("What do you watch?")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.top, 40)

                    Text("Pick 3 or more")
                        .font(.system(size: 14))
                        .foregroundStyle(AppTheme.textMuted)
                        .padding(.top, 4)
                        .padding(.bottom, 20)

                    FlowLayout(spacing: 4) {
                        ForEach(allGenres, id: \.self) { genre in
                            GenrePill(
                                label: genre,
                                isActive: selectedGenres.contains(genre)
                            ) {
                                if selectedGenres.contains(genre) {
                                    selectedGenres.remove(genre)
                                } else {
                                    selectedGenres.insert(genre)
                                }
                            }
                        }
                    }

                    Spacer().frame(height: 24)

                    AppButton(label: "Continue", isDisabled: !canContinue) {
                        navigateToRate = true
                    }
                }
                .padding(.horizontal, 24)
            }
        }
        .background(AppTheme.background)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton()
            }
        }
        .navigationDestination(isPresented: $navigateToRate) {
            RateMoviesView()
        }
    }
}

// MARK: - Flow Layout (wrapping horizontal layout)

struct FlowLayout: Layout {
    var spacing: CGFloat = 4

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = layout(in: proposal.width ?? 0, subviews: subviews)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = layout(in: bounds.width, subviews: subviews)
        for (index, position) in result.positions.enumerated() {
            subviews[index].place(
                at: CGPoint(x: bounds.minX + position.x, y: bounds.minY + position.y),
                proposal: .unspecified
            )
        }
    }

    private func layout(in width: CGFloat, subviews: Subviews) -> (positions: [CGPoint], size: CGSize) {
        var positions: [CGPoint] = []
        var xPos: CGFloat = 0
        var yPos: CGFloat = 0
        var rowHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if xPos + size.width > width, xPos > 0 {
                xPos = 0
                yPos += rowHeight + spacing
                rowHeight = 0
            }
            positions.append(CGPoint(x: xPos, y: yPos))
            rowHeight = max(rowHeight, size.height)
            xPos += size.width + spacing
        }

        return (positions, CGSize(width: width, height: yPos + rowHeight))
    }
}

#Preview {
    NavigationStack {
        PickGenresView()
    }
}
