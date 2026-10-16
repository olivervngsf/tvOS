import SwiftUI

/// Placeholder art: gradient + SF Symbol. Replace with real images later.
struct ArtworkView: View {
    let symbol: String
    let color: Color
    var symbolSize: CGFloat = 90

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [color, color.opacity(0.45)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            Image(systemName: symbol)
                .font(.system(size: symbolSize, weight: .bold))
                .foregroundStyle(.white.opacity(0.9))
        }
    }
}

extension ArtworkView {
    init(film: Film, symbolSize: CGFloat = 90) {
        self.init(symbol: film.symbol, color: film.color, symbolSize: symbolSize)
    }
}
