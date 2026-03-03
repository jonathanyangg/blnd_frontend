import SwiftUI

/// Container that wraps the entire onboarding flow in a NavigationStack.
/// Entry point used by the app when the user is not yet authenticated.
struct OnboardingView: View {
    var body: some View {
        NavigationStack {
            WelcomeView()
        }
    }
}

#Preview {
    OnboardingView()
}
