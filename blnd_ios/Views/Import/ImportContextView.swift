import SwiftUI

/// Pre-webview instructions screen explaining the Letterboxd import flow.
///
/// Pushed onto ProfileView's NavigationStack. Shows Letterboxd branding,
/// numbered steps, and a Continue button that opens LetterboxdWebView
/// as a fullScreenCover.
struct ImportContextView: View {
    @State private var showWebView = false
    @State private var capturedZipData: Data?

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 0) {
                    brandingHeader
                    instructionsCard
                    Spacer(minLength: 40)
                }
            }

            AppButton(label: "Continue") {
                showWebView = true
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 16)
        }
        .background(AppTheme.background)
        .navigationBarBackButtonHidden(false)
        .fullScreenCover(isPresented: $showWebView) {
            LetterboxdWebView { data in
                capturedZipData = data
                showWebView = false
            }
        }
    }

    // MARK: - Branding Header

    private var brandingHeader: some View {
        VStack(spacing: 12) {
            Image(systemName: "film.stack")
                .font(.system(size: 50))
                .foregroundStyle(.white)

            Text("Letterboxd Import")
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(.white)
        }
        .padding(.top, 60)
        .padding(.bottom, 32)
    }

    // MARK: - Instructions Card

    private var instructionsCard: some View {
        VStack(spacing: 16) {
            stepRow(number: 1, text: "Log in to your Letterboxd account")
            stepRow(number: 2, text: "Tap \"Export Your Data\"")
            stepRow(number: 3, text: "We'll handle the rest")
        }
        .padding(20)
        .background(AppTheme.card)
        .clipShape(
            RoundedRectangle(
                cornerRadius: AppTheme.cornerRadiusMedium
            )
        )
        .padding(.horizontal, 24)
    }

    private func stepRow(number: Int, text: String) -> some View {
        HStack(spacing: 12) {
            Text("\(number)")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 28, height: 28)
                .background(AppTheme.cardSecondary)
                .clipShape(Circle())

            Text(text)
                .font(.system(size: 16))
                .foregroundStyle(.white)

            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        ImportContextView()
    }
}
