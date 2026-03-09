import SwiftUI

/// Re-enables the iOS swipe-back gesture on views that hide the navigation back button.
struct SwipeBackGestureModifier: ViewModifier {
    @Environment(\.dismiss) private var dismiss
    @GestureState private var dragOffset: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        if value.startLocation.x < 30 {
                            state = value.translation.width
                        }
                    }
                    .onEnded { value in
                        if value.startLocation.x < 30, value.translation.width > 80 {
                            dismiss()
                        }
                    }
            )
    }
}

extension View {
    func swipeBackGesture() -> some View {
        modifier(SwipeBackGestureModifier())
    }
}
