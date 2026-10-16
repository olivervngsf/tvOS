import SwiftUI

/// Screen 2 — a few picks, with the focused title spelled out below.
struct RecommendationsView: View {
    let mood: Mood
    @FocusState private var focusedID: Film.ID?

    private var films: [Film] { Film.picks(for: mood) }
    private var focusedFilm: Film? {
        films.first { $0.id == focusedID } ?? films.first
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 50) {
            Text(mood.heading)
                .font(.largeTitle.bold())

            HStack(spacing: 60) {
                ForEach(films) { film in
                    NavigationLink(value: film) {
                        ArtworkView(film: film, symbolSize: 120)
                            .frame(width: 480, height: 320)
                    }
                    .buttonStyle(.card)
                    .focused($focusedID, equals: film.id)
                }
            }
            .padding(.vertical, 30) // room for the focus lift

            if let film = focusedFilm {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Focused: \(film.title)")
                        .font(.title2.bold())
                    Text(film.metaLine)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                    Text(film.summary)
                        .font(.body)
                }
                .animation(.easeInOut(duration: 0.2), value: focusedID)
            }

            Spacer()
        }
        .padding(.horizontal, 80)
        .padding(.top, 60)
        .frame(maxWidth: .infinity, alignment: .leading)
        .defaultFocus($focusedID, films.first?.id)
    }
}
