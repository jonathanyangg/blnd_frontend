import SwiftUI

struct ProfileView: View {
    @State private var showSettings = false

    private let stats: [(value: String, label: String)] = [
        ("156", "Rated"),
        ("12", "Friends"),
        ("3", "Groups"),
    ]

    private let ratingColumns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    // Settings gear
                    HStack {
                        Spacer()
                        Button {
                            showSettings = true
                        } label: {
                            Image(systemName: "gearshape")
                                .font(.system(size: 20))
                                .foregroundStyle(AppTheme.textDim)
                        }
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)

                    // Avatar and info
                    VStack(spacing: 0) {
                        AvatarView(size: 80)
                            .padding(.bottom, 12)

                        Text("Jon M.")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundStyle(.white)

                        Text("@jon_m")
                            .font(.system(size: 14))
                            .foregroundStyle(AppTheme.textMuted)
                    }
                    .padding(.bottom, 24)

                    // Stats row
                    HStack {
                        ForEach(stats, id: \.label) { stat in
                            VStack(spacing: 2) {
                                Text(stat.value)
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundStyle(.white)
                                Text(stat.label)
                                    .font(.system(size: 12))
                                    .foregroundStyle(AppTheme.textMuted)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.vertical, 16)
                    .overlay(alignment: .top) {
                        Divider().background(AppTheme.cardSecondary)
                    }
                    .overlay(alignment: .bottom) {
                        Divider().background(AppTheme.cardSecondary)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 28)

                    // Your Ratings
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Your Ratings")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(.white)

                        LazyVGrid(columns: ratingColumns, spacing: 8) {
                            ForEach(0 ..< 6, id: \.self) { index in
                                ZStack(alignment: .bottomTrailing) {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(AppTheme.posterGradient(angle: 120 + index * 20))
                                        .frame(height: 100)

                                    Image(systemName: "star.fill")
                                        .font(.system(size: 10))
                                        .foregroundStyle(.white)
                                        .padding(4)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 32)
                }
            }
            .background(AppTheme.background)
            .navigationDestination(isPresented: $showSettings) {
                SettingsView()
            }
        }
    }
}

#Preview {
    ProfileView()
}
