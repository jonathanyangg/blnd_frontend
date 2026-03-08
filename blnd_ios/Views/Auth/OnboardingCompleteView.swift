import SwiftUI

struct OnboardingCompleteView: View {
    @Environment(AuthState.self) var authState
    @Environment(OnboardingState.self) var onboardingState
    @State private var isSubmitting = false

    var body: some View {
        VStack(spacing: 0) {
            OnboardingProgressBar(step: 4, total: 4)
                .padding(.top, 12)

            Spacer()

            VStack(spacing: 0) {
                Text("You're all set")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundStyle(.white)

                Text("Here's what we think you'll love")
                    .font(.system(size: 14))
                    .foregroundStyle(AppTheme.textMuted)
                    .padding(.top, 6)
                    .padding(.bottom, 32)

                // Fanned movie posters
                HStack(spacing: -8) {
                    MovieCard(
                        title: "Parasite",
                        year: "2019",
                        width: 90,
                        height: 130
                    )
                    .offset(y: 8)

                    MovieCard(
                        title: "Oppenheimer",
                        year: "2023",
                        width: 100,
                        height: 148,
                        glow: true
                    )
                    .zIndex(1)

                    MovieCard(
                        title: "Mad Max",
                        year: "2015",
                        width: 90,
                        height: 130
                    )
                    .offset(y: 8)
                }
            }

            Spacer()

            AppButton(
                label: isSubmitting ? "Setting up..." : "Let's go",
                isLoading: isSubmitting
            ) {
                Task { await submitAndFinish() }
            }
            .disabled(isSubmitting)
            .padding(.horizontal, 24)
            .padding(.bottom, 60)
        }
        .frame(maxWidth: .infinity)
        .background(AppTheme.background)
        .navigationBarBackButtonHidden()
    }

    private func submitAndFinish() async {
        isSubmitting = true

        // Submit genres
        let genres = Array(onboardingState.selectedGenres)
        if !genres.isEmpty {
            _ = try? await AuthAPI.updateProfile(
                favoriteGenres: genres
            )
        }

        // Submit movie ratings (liked → 4.0, disliked → 2.0)
        for (tmdbId, liked) in onboardingState.movieRatings {
            let rating: Double = liked ? 4.0 : 2.0
            _ = try? await TrackingAPI.trackMovie(
                tmdbId: tmdbId,
                rating: rating
            )
        }

        onboardingState.reset()
        authState.isAuthenticated = true
    }
}

#Preview {
    NavigationStack {
        OnboardingCompleteView()
            .environment(AuthState())
            .environment(OnboardingState())
    }
}
