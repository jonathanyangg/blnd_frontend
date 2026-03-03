import SwiftUI

struct AddFriendView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""

    private let suggestions: [(name: String, username: String)] = [
        ("Taylor", "@taylor_w"),
        ("Chris", "@chris_m"),
        ("Jordan", "@jordan_r"),
    ]

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack(spacing: 12) {
                Button { dismiss() } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.white)
                        .font(.system(size: 16, weight: .medium))
                }

                Text("Add Friend")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(.white)

                Spacer()
            }
            .padding(.top, 20)
            .padding(.horizontal, 24)
            .padding(.bottom, 24)

            // Search
            SearchBar(text: $searchText, placeholder: "Search by username...")
                .padding(.horizontal, 24)
                .padding(.bottom, 20)

            // Results
            ForEach(suggestions, id: \.username) { user in
                HStack(spacing: 12) {
                    AvatarView()

                    VStack(alignment: .leading, spacing: 2) {
                        Text(user.name)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.white)
                        Text(user.username)
                            .font(.system(size: 13))
                            .foregroundStyle(AppTheme.textMuted)
                    }

                    Spacer()

                    GenrePill(label: "Add", isSmall: true) {}
                }
                .padding(.vertical, 14)
                .padding(.horizontal, 24)

                Divider()
                    .background(AppTheme.cardSecondary)
                    .padding(.horizontal, 24)
            }

            Spacer()
        }
        .background(AppTheme.background)
        .navigationBarHidden(true)
    }
}

#Preview {
    NavigationStack {
        AddFriendView()
    }
}
