import SwiftUI

struct FriendProfileView: View {
    let name: String
    let username: String
    let matchPercent: Int

    private let stats: [(value: String, label: String)] = [
        ("142", "rated"),
        ("38", "shared"),
        ("12", "friends"),
    ]

    private let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Profile header
                VStack(spacing: 0) {
                    AvatarView(size: 80)
                        .padding(.bottom, 12)

                    Text("\(name) K.")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(.white)

                    Text(username)
                        .font(.system(size: 14))
                        .foregroundStyle(AppTheme.textMuted)
                        .padding(.bottom, 16)

                    TasteMatchBadge(percentage: matchPercent, size: 72)

                    Text("taste match")
                        .font(.system(size: 12))
                        .foregroundStyle(AppTheme.textMuted)
                        .padding(.top, 4)
                }
                .padding(.top, 20)
                .padding(.bottom, 20)

                // Stats row
                HStack {
                    ForEach(stats, id: \.label) { stat in
                        VStack(spacing: 2) {
                            Text(stat.value)
                                .font(.system(size: 18, weight: .bold))
                                .foregroundStyle(.white)
                            Text(stat.label)
                                .font(.system(size: 12))
                                .foregroundStyle(AppTheme.textMuted)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(.bottom, 24)
                .padding(.horizontal, 24)

                // They loved, you haven't seen
                VStack(alignment: .leading, spacing: 12) {
                    Text("They loved, you haven't seen")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(.white)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(0 ..< 3, id: \.self) { index in
                                MovieCard(width: 90, height: 130, gradientAngle: 135 + index * 30)
                            }
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 20)

                // Shared favorites
                VStack(alignment: .leading, spacing: 12) {
                    Text("Shared favorites")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(.white)

                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(0 ..< 4, id: \.self) { index in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(AppTheme.posterGradient(angle: 120 + index * 30))
                                .frame(height: 100)
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
            }
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
        FriendProfileView(name: "Maria", username: "@mariak", matchPercent: 92)
    }
}
