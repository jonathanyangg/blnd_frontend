import SwiftUI

struct FriendsListView: View {
    @State private var showAddFriend = false

    private let friends: [(name: String, username: String, matchPercent: Int)] = [
        ("Alex", "@alex_m", 87),
        ("Maria", "@maria_m", 88),
        ("Jordan", "@jordan_m", 89),
        ("Sam", "@sam_m", 90),
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        Text("Friends")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundStyle(.white)
                        Spacer()
                        Button {
                            showAddFriend = true
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 22, weight: .medium))
                                .foregroundStyle(.white)
                        }
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)

                    // Friend rows
                    ForEach(Array(friends.enumerated()), id: \.offset) { _, friend in
                        NavigationLink {
                            FriendProfileView(
                                name: friend.name,
                                username: friend.username,
                                matchPercent: friend.matchPercent
                            )
                        } label: {
                            FriendRow(
                                name: friend.name,
                                username: friend.username,
                                matchPercent: friend.matchPercent
                            )
                        }
                        .buttonStyle(.plain)

                        Divider()
                            .background(AppTheme.cardSecondary)
                            .padding(.horizontal, 24)
                    }
                }
            }
            .background(AppTheme.background)
            .sheet(isPresented: $showAddFriend) {
                NavigationStack {
                    AddFriendView()
                }
                .presentationBackground(AppTheme.background)
            }
        }
    }
}

// MARK: - Friend Row

private struct FriendRow: View {
    let name: String
    let username: String
    let matchPercent: Int

    var body: some View {
        HStack(spacing: 12) {
            AvatarView()

            VStack(alignment: .leading, spacing: 2) {
                Text(name)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.white)
                Text(username)
                    .font(.system(size: 13))
                    .foregroundStyle(AppTheme.textMuted)
            }

            Spacer()

            TasteMatchBadge(percentage: matchPercent)
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 24)
    }
}

#Preview {
    FriendsListView()
}
