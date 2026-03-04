import Foundation

/// Caches onboarding data so navigating back preserves state.
@Observable
class OnboardingState {
    // Account credentials
    var name = ""
    var email = ""
    var password = ""

    // Preferences
    var selectedGenres: Set<String> = []
    var movieRatings: [UUID: Bool] = [:]

    func reset() {
        name = ""
        email = ""
        password = ""
        selectedGenres = []
        movieRatings = [:]
    }
}
