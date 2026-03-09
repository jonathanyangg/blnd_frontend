import SwiftUI

struct PrivacySettingsView: View {
    @State private var showWatchHistory = true
    @State private var showInSearch = true

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                toggleRow(label: "Show Watch History", isOn: $showWatchHistory)
                Divider().background(AppTheme.cardSecondary)
                toggleRow(label: "Appear in Search", isOn: $showInSearch)
            }
            .background(AppTheme.card)
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadiusLarge))
            .padding(.horizontal, 24)
            .padding(.top, 20)

            Text("Privacy settings coming soon.")
                .font(.system(size: 13))
                .foregroundStyle(AppTheme.textDim)
                .padding(.top, 16)
        }
        .background(AppTheme.background)
        .navigationBarBackButtonHidden()
        .swipeBackGesture()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton()
            }
            ToolbarItem(placement: .principal) {
                Text("Privacy")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(.white)
            }
        }
    }

    private func toggleRow(label: String, isOn: Binding<Bool>) -> some View {
        Toggle(label, isOn: isOn)
            .font(.system(size: 16))
            .foregroundStyle(.white)
            .tint(.green)
            .padding(16)
    }
}
