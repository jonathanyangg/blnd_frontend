import SwiftUI

struct CreateGroupView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var groupName = ""
    @State private var searchText = ""
    @State private var selectedMembers: Set<String> = ["Alex", "Maria"]

    private let allFriends = ["Alex", "Maria", "Jordan", "Sam"]

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Button("Cancel") { dismiss() }
                    .foregroundStyle(AppTheme.textMuted)
                    .font(.system(size: 16))

                Spacer()

                Text("New Group")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.white)

                Spacer()

                Button("Create") {
                    dismiss()
                }
                .foregroundStyle(.white)
                .font(.system(size: 16, weight: .semibold))
            }
            .padding(.top, 20)
            .padding(.horizontal, 24)
            .padding(.bottom, 24)

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Group name input
                    AppTextField(placeholder: "Group name...", text: $groupName)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 8)

                    // Add Members section
                    Text("Add Members")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 12)

                    SearchBar(text: $searchText, placeholder: "Search friends...")
                        .padding(.horizontal, 24)
                        .padding(.bottom, 16)

                    // Selected member chips
                    if !selectedMembers.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(Array(selectedMembers.sorted()), id: \.self) { name in
                                    HStack(spacing: 6) {
                                        AvatarView(size: 20)
                                        Text(name)
                                            .font(.system(size: 13))
                                            .foregroundStyle(.white)
                                        Button {
                                            selectedMembers.remove(name)
                                        } label: {
                                            Image(systemName: "xmark")
                                                .font(.system(size: 10))
                                                .foregroundStyle(AppTheme.textMuted)
                                        }
                                    }
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 12)
                                    .background(AppTheme.card)
                                    .clipShape(Capsule())
                                }
                            }
                            .padding(.horizontal, 24)
                        }
                        .padding(.bottom, 16)
                    }

                    // Friend list with checkboxes
                    ForEach(allFriends, id: \.self) { name in
                        Button {
                            if selectedMembers.contains(name) {
                                selectedMembers.remove(name)
                            } else {
                                selectedMembers.insert(name)
                            }
                        } label: {
                            HStack(spacing: 12) {
                                // Checkbox
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(selectedMembers.contains(name) ? .white : AppTheme.card)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(
                                                selectedMembers.contains(name) ? .white : AppTheme.border,
                                                lineWidth: 1.5
                                            )
                                    )
                                    .frame(width: 20, height: 20)
                                    .overlay {
                                        if selectedMembers.contains(name) {
                                            Image(systemName: "checkmark")
                                                .font(.system(size: 11, weight: .bold))
                                                .foregroundStyle(.black)
                                        }
                                    }

                                AvatarView(size: 36)

                                Text(name)
                                    .font(.system(size: 16))
                                    .foregroundStyle(.white)

                                Spacer()
                            }
                        }
                        .buttonStyle(.plain)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 24)

                        Divider()
                            .background(AppTheme.cardSecondary)
                            .padding(.horizontal, 24)
                    }
                }
            }
        }
        .background(AppTheme.background)
    }
}

#Preview {
    CreateGroupView()
}
