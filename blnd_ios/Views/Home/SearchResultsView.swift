import SwiftUI

struct SearchResultsView: View {
    let query: String

    private let results: [(title: String, year: String)] = [
        ("Inception", "2010"),
        ("Interstellar", "2014"),
        ("Tenet", "2020"),
        ("The Dark Knight", "2008"),
        ("Memento", "2000"),
        ("Batman Begins", "2005"),
    ]

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(Array(results.enumerated()), id: \.offset) { index, movie in
                NavigationLink {
                    MovieDetailView(title: movie.title, year: movie.year)
                } label: {
                    VStack(alignment: .leading, spacing: 4) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(AppTheme.posterGradient(angle: 135 + index * 20))
                            .aspectRatio(155 / 140, contentMode: .fit)

                        Text(movie.title)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.white)
                            .lineLimit(1)

                        Text(movie.year)
                            .font(.system(size: 11))
                            .foregroundStyle(AppTheme.textMuted)
                    }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 24)
        .padding(.top, 20)
    }
}

#Preview {
    ScrollView {
        SearchResultsView(query: "inception")
    }
    .background(AppTheme.background)
}
