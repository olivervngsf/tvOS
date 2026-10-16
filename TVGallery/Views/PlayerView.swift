import SwiftUI
import Combine

/// Fake player to show remote handling:
/// click / Play-Pause = toggle, swipe left/right = seek 10s, Menu = close.
struct PlayerView: View {
    let item: MediaItem
    @Environment(\.dismiss) private var dismiss
    @Environment(LibraryStore.self) private var store

    @State private var isPlaying = false
    @State private var position: Double = 0
    @State private var hint = "Click or press Play/Pause"

    private var duration: Double { Double(item.minutes * 60) }
    private let ticker = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            ArtworkView(item: item, symbolSize: 260)
                .ignoresSafeArea()
                .overlay(Color.black.opacity(0.35).ignoresSafeArea())

            Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                .font(.system(size: 160))
                .foregroundStyle(.white)

            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 16) {
                    Text(item.title).font(.title2.bold())
                    ProgressView(value: position, total: duration)
                        .tint(.white)
                    HStack {
                        Text(format(position))
                        Spacer()
                        Text(hint).foregroundStyle(.white.opacity(0.7))
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
        .onTapGesture { togglePlay() }          // touch-surface click
        .onPlayPauseCommand { togglePlay() }    // Play/Pause button
        .onMoveCommand { direction in           // swipe / arrow
            switch direction {
            case .left: seek(-10)
            case .right: seek(10)
            default: break
            }
        }
        .onExitCommand { dismiss() }            // Menu / Back button
        .onReceive(ticker) { _ in
            guard isPlaying else { return }
            position = min(position + 1, duration)
            if position >= duration { isPlaying = false }
        }
        .onAppear { if store.autoplay { isPlaying = true } }
    }

    private func togglePlay() {
        isPlaying.toggle()
        hint = isPlaying ? "Playing" : "Paused"
    }

    private func seek(_ seconds: Double) {
        position = min(max(position + seconds, 0), duration)
        hint = seconds > 0 ? "+10s" : "-10s"
    }

    private func format(_ seconds: Double) -> String {
        let s = Int(seconds)
        return String(format: "%d:%02d", s / 60, s % 60)
    }
}
