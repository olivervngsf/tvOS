import SwiftUI

/// Screen 1 — three simple entry points instead of a large catalog.
struct DiscoverView: View {
    @FocusState private var focused: Mood?

    private var current: Mood { focused ?? .relaxing }

    var body: some View {
        ZStack {
            // Background follows the focused mood.
            BackdropView(symbol: current.symbol, color: current.color)
                .id(current)
                .transition(.opacity)

            VStack(alignment: .leading, spacing: 0) {
                Wordmark()
                Spacer()

                Text("What are you in the mood for?")
                    .font(.largeTitle.weight(.heavy))
                Text("Pick a mood. We'll find you three great picks.")
                    .font(.title3)
                    .foregroundStyle(.white.opacity(0.75))
                    .padding(.top, 12)

                HStack(spacing: 50) {
                    ForEach(Mood.allCases) { mood in
                        NavigationLink(value: mood) {
                            MoodTile(mood: mood)
                        }
                        .buttonStyle(.card)
                        .focused($focused, equals: mood)
                    }
                }
                .padding(.top, 50)
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
        .animation(.easeInOut(duration: 0.4), value: current)
        .defaultFocus($focused, .relaxing)
    }
}

private struct MoodTile: View {
    let mood: Mood

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: mood.symbol)
                .font(.system(size: 64, weight: .bold))
            Spacer()
            Text(mood.label)
                .font(.title2.bold())
            Text(mood.subtitle)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.8))
        }
        .foregroundStyle(.white)
        .padding(32)
        .frame(width: 480, height: 280, alignment: .leading)
        .background(
            LinearGradient(
                colors: [mood.color, mood.color.opacity(0.35)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }
}
