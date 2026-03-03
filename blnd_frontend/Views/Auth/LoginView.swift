import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Sign in")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.top, 40)
                        .padding(.bottom, 32)

                    AppTextField(placeholder: "Email", text: $email)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                    AppTextField(placeholder: "Password", text: $password, isSecure: true)

                    Spacer().frame(height: 20)

                    AppButton(label: "Sign In") {
                        // Will wire to AuthState later
                    }

                    HStack(spacing: 4) {
                        Text("Don't have an account?")
                            .foregroundStyle(AppTheme.textMuted)
                        Text("Create one")
                            .foregroundStyle(.white)
                    }
                    .font(.system(size: 14))
                    .frame(maxWidth: .infinity)
                    .padding(.top, 20)
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

// MARK: - Reusable back button for navigation

struct BackButton: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundStyle(.white)
                .font(.system(size: 16, weight: .medium))
        }
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}
