import SwiftUI

struct MovieDetailView: View {
    let title: String
    let year: String

    @State private var showRatingSheet = false
    @State private var isInWatchlist = false

    private let genres = ["Action", "Sci-Fi", "Thriller"]
    private let cast = ["DiCaprio", "Page", "Hardy", "Cotillard"]
    private let description = "A thief who steals corporate secrets through dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O."
    private let runtime = "2h 28m"

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Hero poster / backdrop
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(AppTheme.posterGradient)
                        .frame(height: 200)

                    Image(systemName: "play.fill")
                        .font(.system(size: 22))
                        .foregroundStyle(.white)
                        .frame(width: 52, height: 52)
                        .background(.white.opacity(0.2))
                        .clipShape(Circle())
                }
                .padding(.top, 12)
                .padding(.horizontal, 24)

                VStack(alignment: .leading, spacing: 0) {
                    Text(title)
                        .font(.system(size: 26, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.top, 16)

                    Text("\(year) \u{00B7} \(runtime)")
                        .font(.system(size: 14))
                        .foregroundStyle(AppTheme.textMuted)
                        .padding(.top, 4)
                        .padding(.bottom, 10)

                    // Genre pills
                    HStack(spacing: 6) {
                        ForEach(genres, id: \.self) { genre in
                            GenrePill(label: genre, isSmall: true)
                        }
                    }
                    .padding(.bottom, 12)

                    // Star rating
                    HStack(spacing: 2) {
                        ForEach(0 ..< 5, id: \.self) { _ in
                            Image(systemName: "star.fill")
                                .font(.system(size: 16))
                                .foregroundStyle(.white)
                        }
                    }
                    .padding(.bottom, 8)
                    .onTapGesture {
                        showRatingSheet = true
                    }

                    // Description
                    Text(description)
                        .font(.system(size: 14))
                        .foregroundStyle(AppTheme.textMuted)
                        .lineSpacing(4)
                        .padding(.bottom, 16)

                    // Action buttons
                    HStack(spacing: 10) {
                        Button {
                            showRatingSheet = true
                        } label: {
                            Text("Watched")
                                .font(.system(size: 15, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 13)
                                .background(AppTheme.card)
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadiusMedium))
                        }

                        Button {
                            isInWatchlist.toggle()
                        } label: {
                            Text(isInWatchlist ? "In Watchlist" : "+ Watchlist")
                                .font(.system(size: 15, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 13)
                                .background(isInWatchlist ? AppTheme.card : .white)
                                .foregroundStyle(isInWatchlist ? .white : .black)
                                .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadiusMedium))
                        }
                    }
                    .padding(.bottom, 20)

                    // Cast
                    Text("Cast")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.bottom, 12)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(cast, id: \.self) { name in
                                VStack(spacing: 4) {
                                    AvatarView(size: 48)
                                    Text(name)
                                        .font(.system(size: 10))
                                        .foregroundStyle(.white)
                                        .lineLimit(1)
                                        .frame(width: 48)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 24)
            }
            .padding(.bottom, 32)
        }
        .background(AppTheme.background)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton()
            }
        }
        .sheet(isPresented: $showRatingSheet) {
            RateMovieSheet(title: title, year: year)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
                .presentationBackground(AppTheme.card)
        }
    }
}

#Preview {
    NavigationStack {
        MovieDetailView(title: "Inception", year: "2010")
    }
}
