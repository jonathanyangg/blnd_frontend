import SwiftUI

/// Landing screen that routes to Sign Up or Login.
/// Not explicitly in the JSX mockup, but serves as the entry point before onboarding.
struct WelcomeView: View {
    @State private var showSignUp = false
    @State private var showLogin = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Spacer()

                VStack(spacing: 8) {
                    Text("blnd")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundStyle(.white)

                    Text("Find what to watch together")
                        .font(.system(size: 16))
                        .foregroundStyle(AppTheme.textMuted)
                }

                Spacer()

                VStack(spacing: 8) {
                    AppButton(label: "Create Account") {
                        showSignUp = true
                    }

                    AppButton(label: "Sign In", style: .ghost) {
                        showLogin = true
                    }
                }
                .padding(.bottom, 48)
            }
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppTheme.background)
            .navigationDestination(isPresented: $showSignUp) {
                SignUpView()
            }
            .navigationDestination(isPresented: $showLogin) {
                LoginView()
            }
        }
    }
}

#Preview {
    WelcomeView()
}
