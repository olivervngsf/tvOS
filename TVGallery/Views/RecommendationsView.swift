import SwiftUI

/// Screen 2 — a few picks; the focused one takes over the whole screen.
struct RecommendationsView: View {
    let mood: Mood
    @FocusState private var focusedID: Film.ID?

    private var films: [Film] { Film.picks(for: mood) }
    private var current: Film {
        films.first { $0.id == focusedID } ?? films[0]
    }

    var body: some View {
        ZStack {
            BackdropView(film: current)
                .id(current.id)
                .transition(.opacity)

            VStack(alignment: .leading, spacing: 0) {
                Wordmark()
                Spacer()

                // Focused title, spelled out big.
                VStack(alignment: .leading, spacing: 16) {
                    if current.id == films.first?.id {
                        Text("TOP PICK FOR YOU")
                            .font(.caption.bold())
                            .kerning(2)
                            .foregroundStyle(Theme.accent)
                    }
                    Text(current.title)
                        .font(.largeTitle.weight(.heavy))
                    FilmMetaRow(film: current)
                    Text(current.summary)
                        .font(.title3)
                        .foregroundStyle(.white.opacity(0.85))
                        .frame(maxWidth: 900, alignment: .leading)
                }
                .id(current.id)
                .transition(.opacity)

                Text(mood.heading)
                    .font(.title3.bold())
                    .padding(.top, 50)

                HStack(spacing: 40) {
                    ForEach(films) { film in
                        NavigationLink(value: film) {
                            PosterTile(film: film)
                        }
                        .buttonStyle(.card)
                        .focused($focusedID, equals: film.id)
                    }
                }
                .padding(.vertical, 24) // room for the focus lift
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
        .animation(.easeInOut(duration: 0.35), value: current.id)
        .defaultFocus($focusedID, films.first?.id)
    }
}

private struct PosterTile: View {
    let film: Film

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            ArtworkView(film: film, symbolSize: 100)
            LinearGradient(colors: [.clear, .black.opacity(0.8)], startPoint: .center, endPoint: .bottom)
            Text(film.title)
                .font(.headline)
                .foregroundStyle(.white)
                .padding(20)
        }
        .frame(width: 440, height: 248)
    }
}
