import SwiftUI

@main
struct BlndApp: App {
    @State private var authState = AuthState()
    @State private var onboardingState = OnboardingState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(authState)
                .environment(onboardingState)
        }
    }
}
