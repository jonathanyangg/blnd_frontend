import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @State private var isSearching = false

    private let sections: [(title: String, movies: [(title: String, year: String)])] = [
        ("For You", [
            ("Dune", "2021"), ("Arrival", "2016"), ("Tenet", "2020"), ("Her", "2013"),
        ]),
        ("Trending", [
            ("Oppenheimer", "2023"), ("Killers of the Flower Moon", "2023"),
            ("Past Lives", "2023"), ("Barbie", "2023"),
        ]),
        ("Because you liked Interstellar", [
            ("Gravity", "2013"), ("The Martian", "2015"),
            ("Ad Astra", "2019"), ("Arrival", "2016"),
        ]),
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    if isSearching {
                        SearchBar(text: $searchText) {
                            isSearching = false
                        }
                        .padding(.top, 16)
                        .padding(.horizontal, 24)

                        if !searchText.isEmpty {
                            SearchResultsView(query: searchText)
                        }
                    } else {
                        SearchBarButton(placeholder: "Search movies...") {
                            isSearching = true
                        }
                        .padding(.top, 16)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 24)

                        ForEach(Array(sections.enumerated()), id: \.offset) { index, section in
                            MovieSectionRow(
                                title: section.title,
                                movies: section.movies
                            )

                            if index < sections.count - 1 {
                                Divider()
                                    .background(AppTheme.cardSecondary)
                                    .padding(.vertical, 0)
                            }
                        }
                    }
                }
                .padding(.bottom, 16)
            }
            .background(AppTheme.background)
            .animation(.easeInOut(duration: 0.2), value: isSearching)
        }
    }
}

// MARK: - Movie Section Row

private struct MovieSectionRow: View {
    let title: String
    let movies: [(title: String, year: String)]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(.white)
                Spacer()
                Button("See all") {}
                    .font(.system(size: 14))
                    .foregroundStyle(AppTheme.textMuted)
            }
            .padding(.horizontal, 24)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(Array(movies.enumerated()), id: \.offset) { _, movie in
                        NavigationLink {
                            MovieDetailView(title: movie.title, year: movie.year)
                        } label: {
                            MovieCard(
                                title: movie.title,
                                year: movie.year
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 24)
            }
        }
        .padding(.bottom, 24)
    }
}

#Preview {
    HomeView()
}
