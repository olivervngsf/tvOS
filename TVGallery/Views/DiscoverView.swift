import SwiftUI

/// Screen 1 — three simple entry points instead of a large catalog.
struct DiscoverView: View {
    @FocusState private var focused: Mood?

    var body: some View {
        VStack(spacing: 80) {
            VStack(spacing: 16) {
                Text("What are you in the mood for?")
                    .font(.largeTitle.bold())
                Text("Pick one. We'll keep it short.")
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }

            HStack(spacing: 60) {
                ForEach(Mood.allCases) { mood in
                    NavigationLink(value: mood) {
                        VStack(spacing: 24) {
                            Image(systemName: mood.symbol)
                                .font(.system(size: 110, weight: .bold))
                            Text(mood.label)
                                .font(.title2.bold())
                        }
                        .foregroundStyle(.white)
                        .frame(width: 420, height: 360)
                        .background(LinearGradient(colors: [mood.color, mood.color.opacity(0.45)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    }
                    .buttonStyle(.card)
                    .focused($focused, equals: mood)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .defaultFocus($focused, .relaxing)
    }
}
