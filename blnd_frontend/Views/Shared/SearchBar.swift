import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String = "Search movies..."
    var onClear: (() -> Void)? = nil

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(AppTheme.textDim)
                .font(.system(size: 15))

            if text.isEmpty {
                Text(placeholder)
                    .font(.system(size: 15))
                    .foregroundStyle(AppTheme.textMuted)
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                TextField("", text: $text)
                    .font(.system(size: 15))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
            }

            if !text.isEmpty {
                Button {
                    text = ""
                    onClear?()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(AppTheme.textMuted)
                        .font(.system(size: 13))
                }
            }
        }
        .padding(14)
        .background(AppTheme.card)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadiusMedium))
    }
}

// Non-interactive version for tappable search bar
struct SearchBarButton: View {
    var placeholder: String = "Search movies..."
    var action: () -> Void = {}

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(AppTheme.textDim)
                    .font(.system(size: 15))

                Text(placeholder)
                    .font(.system(size: 15))
                    .foregroundStyle(AppTheme.textMuted)

                Spacer()
            }
            .padding(14)
            .background(AppTheme.card)
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadiusMedium))
        }
    }
}

#Preview {
    VStack {
        SearchBar(text: .constant(""))
        SearchBar(text: .constant("inception"))
        SearchBarButton()
    }
    .padding()
    .background(AppTheme.background)
}
