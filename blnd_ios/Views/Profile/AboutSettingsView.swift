import SwiftUI

struct AboutSettingsView: View {
    private let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // App icon / branding
                VStack(spacing: 8) {
                    Text("blnd")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundStyle(.white)
                    Text("v\(appVersion)")
                        .font(.system(size: 14))
                        .foregroundStyle(AppTheme.textMuted)
                }
                .padding(.top, 32)

                VStack(spacing: 0) {
                    infoRow(label: "Version", value: appVersion)
                    Divider().background(AppTheme.cardSecondary)
                    infoRow(label: "Built with", value: "SwiftUI")
                }
                .background(AppTheme.card)
                .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadiusLarge))

                Text("Sync your movie taste with friends.")
                    .font(.system(size: 14))
                    .foregroundStyle(AppTheme.textDim)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 24)
        }
        .background(AppTheme.background)
        .navigationBarBackButtonHidden()
        .swipeBackGesture()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton()
            }
            ToolbarItem(placement: .principal) {
                Text("About")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(.white)
            }
        }
    }

    private func infoRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .font(.system(size: 16))
                .foregroundStyle(.white)
            Spacer()
            Text(value)
                .font(.system(size: 16))
                .foregroundStyle(AppTheme.textMuted)
        }
        .padding(16)
    }
}
