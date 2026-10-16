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
        ZStack {
            BackdropView(film: film)

            VStack(alignment: .leading, spacing: 20) {
                Wordmark()
                Spacer()

                Text(film.mood.heading.uppercased())
                    .font(.caption.bold())
                    .kerning(2)
                    .foregroundStyle(Theme.accent)
                Text(film.title)
                    .font(.system(size: 96, weight: .black))
                FilmMetaRow(film: film)
                Text(film.summary)
                    .font(.title3)
                    .frame(maxWidth: 900, alignment: .leading)
                Text(film.tags)
                    .font(.callout)
                    .foregroundStyle(.white.opacity(0.7))

                HStack(spacing: 30) {
                    Button {
                        foundIn = clock.elapsedSeconds
                        playing = true
                    } label: {
                        Label("Play", systemImage: "play.fill")
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
                .buttonStyle(PillButtonStyle())
                .padding(.top, 20)

                // More info expands in place: no extra screen to navigate.
                if showMore {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Starring: \(film.starring)")
                        Text("Director: \(film.director)")
                        Text("Genre: \(film.genre) · Rated \(film.rating) · \(film.runtime)")
                    }
                    .font(.callout)
                    .foregroundStyle(.white.opacity(0.8))
                    .padding(28)
                    .background(.white.opacity(0.08), in: RoundedRectangle(cornerRadius: 16))
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding(.bottom, 20)
        }
        .defaultFocus($focused, .play)
        .fullScreenCover(isPresented: $playing) {
            PlayerView(film: film, foundIn: foundIn)
        }
    }
}
