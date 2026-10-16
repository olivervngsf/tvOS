import SwiftUI
import Combine

/// Fake player = end of the task. Shows how long it took to find something.
/// click / Play-Pause = toggle, swipe left/right = seek 10s, Menu = close.
struct PlayerView: View {
    let film: Film
    let foundIn: Int
    @Environment(\.dismiss) private var dismiss
    @Environment(SessionClock.self) private var clock

    @State private var isPlaying = true
    @State private var position: Double = 0
    @State private var showBadge = true

    private var duration: Double { Double(film.minutes * 60) }
    private let ticker = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea() // solid base so the Decide screen doesn't show through
            ArtworkView(film: film, symbolSize: 260)
                .ignoresSafeArea()
                .overlay(Color.black.opacity(0.35).ignoresSafeArea())

            Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                .font(.system(size: 160))
                .foregroundStyle(.white)

            VStack {
                if showBadge {
                    Label(
                        "Found in \(foundIn)s · target under 60s",
                        systemImage: foundIn < 60 ? "checkmark.circle.fill" : "clock"
                    )
                    .font(.title3.bold())
                    .padding(.horizontal, 30)
                    .padding(.vertical, 16)
                    .background(.ultraThinMaterial, in: Capsule())
                    .padding(.top, 60)
                    .transition(.opacity)
                }
                Spacer()
                VStack(alignment: .leading, spacing: 16) {
                    Text(film.title).font(.title2.bold())
                    ProgressView(value: position, total: duration)
                        .tint(.white)
                    HStack {
                        Text(format(position))
                        Spacer()
                        Text("-" + format(duration - position))
                    }
                    .font(.callout.monospacedDigit())
                }
                .foregroundStyle(.white)
                .padding(80)
            }
        }
        .focusable()
        .onTapGesture { isPlaying.toggle() }          // touch-surface click
        .onPlayPauseCommand { isPlaying.toggle() }    // Play/Pause button
        .onMoveCommand { direction in                 // swipe / arrow
            switch direction {
            case .left: seek(-10)
            case .right: seek(10)
            default: break
            }
        }
        .onExitCommand { dismiss() }                  // Menu / Back button
        .onReceive(ticker) { _ in
            guard isPlaying else { return }
            position = min(position + 1, duration)
            if position >= duration { isPlaying = false }
        }
        .task {
            try? await Task.sleep(for: .seconds(4))
            withAnimation { showBadge = false }
        }
        .onDisappear { clock.reset() } // next search starts a fresh timer
    }

    private func seek(_ seconds: Double) {
        position = min(max(position + seconds, 0), duration)
    }

    private func format(_ seconds: Double) -> String {
        let s = Int(seconds)
        return String(format: "%d:%02d", s / 60, s % 60)
    }
}
