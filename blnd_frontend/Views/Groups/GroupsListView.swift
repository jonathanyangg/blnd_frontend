import SwiftUI

struct GroupsListView: View {
    @State private var showCreateGroup = false

    private let groups: [(name: String, members: String, count: Int)] = [
        ("Movie Night Crew", "5 members", 3),
        ("Sci-Fi Club", "3 members", 3),
        ("Weekend Watch", "8 members", 3),
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        Text("Groups")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundStyle(.white)
                        Spacer()
                        Button {
                            showCreateGroup = true
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 22, weight: .medium))
                                .foregroundStyle(.white)
                        }
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 20)

                    // Group cards
                    ForEach(groups, id: \.name) { group in
                        NavigationLink {
                            GroupDetailView(
                                name: group.name,
                                memberCount: group.count
                            )
                        } label: {
                            GroupCardRow(
                                name: group.name,
                                subtitle: group.members,
                                avatarCount: group.count
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .background(AppTheme.background)
            .sheet(isPresented: $showCreateGroup) {
                CreateGroupView()
                    .presentationBackground(AppTheme.background)
            }
        }
    }
}

// MARK: - Group Card Row

private struct GroupCardRow: View {
    let name: String
    let subtitle: String
    let avatarCount: Int

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                Text(subtitle)
                    .font(.system(size: 13))
                    .foregroundStyle(AppTheme.textMuted)
            }

            Spacer()

            HStack(spacing: 0) {
                ForEach(0 ..< avatarCount, id: \.self) { i in
                    AvatarView(size: 28, overlap: i > 0)
                }
            }
        }
        .padding(16)
        .background(AppTheme.card)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadiusLarge))
        .padding(.horizontal, 24)
        .padding(.bottom, 12)
    }
}

#Preview {
    GroupsListView()
}
