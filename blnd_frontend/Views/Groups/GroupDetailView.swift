import SwiftUI

struct GroupDetailView: View {
    let name: String
    let memberCount: Int

    private let watchlist: [(title: String, year: String, addedBy: String)] = [
        ("Parasite", "2019", "added by Alex"),
        ("Tenet", "2020", "added by Maria"),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Title
                Text(name)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.top, 20)
                    .padding(.bottom, 8)

                // Members row
                HStack(spacing: 8) {
                    HStack(spacing: 0) {
                        ForEach(0 ..< min(memberCount, 3), id: \.self) { i in
                            AvatarView(size: 28, overlap: i > 0)
                        }

                        if memberCount > 3 {
                            ZStack {
                                Circle()
                                    .fill(AppTheme.card)
                                    .frame(width: 28, height: 28)
                                    .overlay(
                                        Circle().stroke(AppTheme.background, lineWidth: 2)
                                    )
                                Text("+\(memberCount - 3)")
                                    .font(.system(size: 10))
                                    .foregroundStyle(.white)
                            }
                            .padding(.leading, -10)
                        }
                    }

                    Text("\(memberCount) members")
                        .font(.system(size: 13))
                        .foregroundStyle(AppTheme.textMuted)
                }
                .padding(.bottom, 20)

                // Blend Picks
                Text("Blend Picks")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.bottom, 4)

                Text("Recommended for your group")
                    .font(.system(size: 12))
                    .foregroundStyle(AppTheme.textMuted)
                    .padding(.bottom, 12)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(0 ..< 4, id: \.self) { i in
                            MovieCard(width: 90, height: 130, gradientAngle: 135 + i * 20)
                        }
                    }
                }
                .padding(.bottom, 20)

                // Watchlist
                Text("Watchlist")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.bottom, 12)

                ForEach(watchlist, id: \.title) { item in
                    HStack(spacing: 12) {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(AppTheme.posterGradient)
                            .frame(width: 40, height: 56)

                        VStack(alignment: .leading, spacing: 2) {
                            Text(item.title)
                                .font(.system(size: 15, weight: .medium))
                                .foregroundStyle(.white)
                            Text(item.year)
                                .font(.system(size: 12))
                                .foregroundStyle(AppTheme.textMuted)
                            Text(item.addedBy)
                                .font(.system(size: 11))
                                .foregroundStyle(AppTheme.textDim)
                        }

                        Spacer()
                    }
                    .padding(.vertical, 12)

                    Divider()
                        .background(AppTheme.cardSecondary)
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
        }
        .background(AppTheme.background)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton()
            }
        }
    }
}

#Preview {
    NavigationStack {
        GroupDetailView(name: "Movie Night Crew", memberCount: 5)
    }
}
