import SwiftUI

struct SignUpView: View {
    @Environment(OnboardingState.self) var onboardingState
    @Binding var path: NavigationPath

    var body: some View {
        VStack(spacing: 0) {
            OnboardingProgressBar(step: 1, total: 4)
                .padding(.top, 12)

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Create account")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.top, 40)
                        .padding(.bottom, 32)

                    @Bindable var state = onboardingState

                    AppTextField(placeholder: "Name", text: $state.name)
                    AppTextField(placeholder: "Email", text: $state.email)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                    AppTextField(placeholder: "Password", text: $state.password, isSecure: true)

                    Spacer().frame(height: 20)

                    AppButton(
                        label: "Continue",
                        isDisabled: state.name.isEmpty || state.email.isEmpty || state.password.isEmpty
                    ) {
                        path.append(AuthRoute.pickGenres)
                    }

                    Button {
                        // Pop to root, then push login
                        path.removeLast(path.count)
                        path.append(AuthRoute.login)
                    } label: {
                        HStack(spacing: 4) {
                            Text("Already have an account?")
                                .foregroundStyle(AppTheme.textMuted)
                            Text("Sign in")
                                .foregroundStyle(.white)
                        }
                        .font(.system(size: 14))
                        .frame(maxWidth: .infinity)
                        .padding(.top, 20)
                    }
                }
                .padding(.horizontal, 24)
            }
        }
        .background(AppTheme.background)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton()
            }
        }
    }
}

// MARK: - Styled Text Field

struct AppTextField: View {
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false

    var body: some View {
        Group {
            if isSecure {
                SecureField("", text: $text, prompt: promptText)
            } else {
                TextField("", text: $text, prompt: promptText)
            }
        }
        .font(.system(size: 15))
        .foregroundStyle(.white)
        .padding(16)
        .background(AppTheme.card)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadiusMedium))
        .padding(.bottom, 12)
    }

    private var promptText: Text {
        Text(placeholder)
            .foregroundStyle(AppTheme.textMuted)
    }
}

#Preview {
    NavigationStack {
        SignUpView(path: .constant(NavigationPath()))
            .environment(AuthState())
            .environment(OnboardingState())
    }
}
