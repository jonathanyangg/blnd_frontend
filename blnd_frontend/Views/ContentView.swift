import SwiftUI

/// Root view that gates on authentication status.
/// Shows onboarding flow for unauthenticated users, main tab view for authenticated users.
struct ContentView: View {
    // Will be replaced with @Environment(AuthState.self) when AuthState is wired up
    @State private var isAuthenticated = true // Set to true for UI preview; false for onboarding flow

    var body: some View {
        Group {
            if isAuthenticated {
                MainTabView()
            } else {
                OnboardingView()
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview("Authenticated") {
    ContentView()
}

#Preview("Onboarding") {
    ContentView()
}
