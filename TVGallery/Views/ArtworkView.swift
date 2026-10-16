import SwiftUI

/// Placeholder poster art: gradient + SF Symbol. Replace with real images later.
struct ArtworkView: View {
    let item: MediaItem
    var symbolSize: CGFloat = 90

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [item.color, item.color.opacity(0.45)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            Image(systemName: item.symbol)
                .font(.system(size: symbolSize, weight: .bold))
                .foregroundStyle(.white.opacity(0.9))
        }
    }
}
