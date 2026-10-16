import SwiftUI

/// Screen 3 — the next action is obvious: Play is focused on arrival.
struct DecideView: View {
    let film: Film
    @Environment(SessionClock.self) private var clock
    @FocusState private var focused: Field?
    @State private var showMore = false
    @State private var playing = false
    @State private var foundIn = 0

    private enum Field { case play, more }

    var body: some View {
        HStack(alignment: .top, spacing: 70) {
            ArtworkView(film: film, symbolSize: 180)
                .frame(width: 560, height: 760)
                .clipShape(RoundedRectangle(cornerRadius: 24))

            VStack(alignment: .leading, spacing: 24) {
                Text(film.title)
                    .font(.largeTitle.bold())
                Text(film.metaLine)
                    .font(.title3)
                    .foregroundStyle(.secondary)
                Text(film.summary)
                    .font(.body)

                HStack(spacing: 30) {
                    Button {
                        foundIn = clock.elapsedSeconds
                        playing = true
                    } label: {
                        Label("Play", systemImage: "play.fill")
                            .padding(.horizontal, 30)
                    }
                    .focused($focused, equals: .play)

                    Button {
                        withAnimation(.easeInOut(duration: 0.25)) { showMore.toggle() }
                    } label: {
                        Label(showMore ? "Less info" : "More info",
                              systemImage: showMore ? "chevron.up" : "info.circle")
                    }
                    .focused($focused, equals: .more)
                }
                .padding(.top, 20)

                // More info expands in place: no extra screen to navigate.
                if showMore {
                    Text(film.details)
                        .font(.callout)
                        .foregroundStyle(.secondary)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                }

                Spacer()
            }
            .frame(maxWidth: 900, alignment: .leading)
        }
        .padding(80)
        .defaultFocus($focused, .play)
        .fullScreenCover(isPresented: $playing) {
            PlayerView(film: film, foundIn: foundIn)
        }
    }
}
