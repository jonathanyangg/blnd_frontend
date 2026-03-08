import Foundation

/// Caches onboarding data so navigating back preserves state.
@Observable
class OnboardingState {
    var name = ""
    var username = ""
    var email = ""
    var password = ""

    var selectedGenres: Set<String> = []
    var movieRatings: [Int: Bool] = [:]

    func reset() {
        name = ""
        username = ""
        email = ""
        password = ""
        selectedGenres = []
        movieRatings = [:]
    }
}
