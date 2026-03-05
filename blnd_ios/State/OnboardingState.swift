import Foundation

/// Caches onboarding data so navigating back preserves state.
@Observable
class OnboardingState {
    var name = ""
    var email = ""
    var password = ""

    var selectedGenres: Set<String> = []
    var movieRatings: [Int: Bool] = [:]

    func reset() {
        name = ""
        email = ""
        password = ""
        selectedGenres = []
        movieRatings = [:]
    }
}
