import SwiftUI

struct AddFriendView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var query = ""
    @State private var results: [UserSearchResult] = []
    @State private var isSearching = false
    @State private var searchTask: Task<Void, Never>?

    // Request state
    @State private var sendingTo: String?
    @State private var sentTo: Set<String> = []
    @State private var errorMessage: String?

    @FocusState private var isFieldFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            header
            searchField
                .padding(.horizontal, 24)
                .padding(.bottom, 12)

            if let errorMessage {
                Text(errorMessage)
                    .font(.system(size: 13))
                    .foregroundStyle(.red)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 8)
            }

            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(results) { user in
                        userRow(user)
                    }
                }
            }
        }
        .background(AppTheme.background)
        .navigationBarHidden(true)
        .onAppear { isFieldFocused = true }
    }

    // MARK: - Header

    private var header: some View {
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
    }

    // MARK: - Search Field

    private var searchField: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 14))
                .foregroundStyle(AppTheme.textDim)
            TextField("Search by username...", text: $query)
                .font(.system(size: 16))
                .foregroundStyle(.white)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .focused($isFieldFocused)
                .onChange(of: query) { _, newValue in
                    debounceSearch(newValue)
                }
            if isSearching {
                ProgressView()
                    .tint(AppTheme.textMuted)
                    .controlSize(.small)
            } else if !query.isEmpty {
                Button {
                    query = ""
                    results = []
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 14))
                        .foregroundStyle(AppTheme.textDim)
                }
            }
        }
        .padding(14)
        .background(AppTheme.card)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadiusMedium))
    }

    // MARK: - User Row

    private func userRow(_ user: UserSearchResult) -> some View {
        HStack(spacing: 12) {
            AvatarView(url: user.avatarUrl, size: 44)

            VStack(alignment: .leading, spacing: 2) {
                Text(user.displayName ?? user.username)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.white)
                Text("@\(user.username)")
                    .font(.system(size: 13))
                    .foregroundStyle(AppTheme.textMuted)
            }

            Spacer()

            if sentTo.contains(user.id) {
                Text("Sent")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(AppTheme.textMuted)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 7)
                    .background(AppTheme.card)
                    .clipShape(Capsule())
            } else {
                Button {
                    Task { await sendRequest(to: user) }
                } label: {
                    if sendingTo == user.id {
                        ProgressView()
                            .tint(.black)
                            .controlSize(.small)
                            .frame(width: 50)
                    } else {
                        Text("Add")
                            .font(.system(size: 13, weight: .semibold))
                    }
                }
                .foregroundStyle(.black)
                .padding(.horizontal, 14)
                .padding(.vertical, 7)
                .background(.white)
                .clipShape(Capsule())
                .disabled(sendingTo != nil)
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 10)
    }

    // MARK: - Search Logic

    private func debounceSearch(_ value: String) {
        searchTask?.cancel()
        let trimmed = value.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else {
            results = []
            isSearching = false
            return
        }
        isSearching = true
        searchTask = Task {
            try? await Task.sleep(for: .milliseconds(300))
            guard !Task.isCancelled else { return }
            do {
                let response = try await AuthAPI.searchUsers(query: trimmed)
                if !Task.isCancelled {
                    results = response.results
                }
            } catch {
                if !Task.isCancelled {
                    results = []
                }
            }
            isSearching = false
        }
    }

    private func sendRequest(to user: UserSearchResult) async {
        sendingTo = user.id
        errorMessage = nil
        do {
            _ = try await FriendsAPI.sendRequest(username: user.username)
            sentTo.insert(user.id)
        } catch let APIError.badRequest(message) {
            errorMessage = message
        } catch {
            errorMessage = error.localizedDescription
        }
        sendingTo = nil
    }
}

#Preview {
    NavigationStack {
        AddFriendView()
    }
}
