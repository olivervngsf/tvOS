import SwiftUI

struct DetailView: View {
    let item: MediaItem
    @Environment(LibraryStore.self) private var store
    @FocusState private var focused: Field?
    @State private var showPlayer = false

    private enum Field { case play, favorite }

    var body: some View {
        HStack(alignment: .top, spacing: 60) {
            ArtworkView(item: item, symbolSize: 180)
                .frame(width: 600, height: 760)
                .clipShape(RoundedRectangle(cornerRadius: 24))

            VStack(alignment: .leading, spacing: 24) {
                Text(item.title)
                    .font(.system(size: 76, weight: .bold))
                Text("\(item.genre) · \(String(item.year)) · \(item.minutes) min")
                    .font(.title3)
                    .foregroundStyle(.secondary)
                Text(item.summary)
                    .font(.body)
                    .frame(maxWidth: 900, alignment: .leading)

                HStack(spacing: 30) {
                    Button {
                        showPlayer = true
                    } label: {
                        Label("Play", systemImage: "play.fill")
                            .padding(.horizontal, 20)
                    }
                    .focused($focused, equals: .play)

                    Button {
                        store.toggleFavorite(item)
                    } label: {
                        Label(
                            store.isFavorite(item) ? "Favorited" : "Add to Favorites",
                            systemImage: store.isFavorite(item) ? "heart.fill" : "heart"
                        )
                    }
                    .focused($focused, equals: .favorite)
                }
                .padding(.top, 20)

                Spacer()
            }
        }
        .padding(80)
        .onAppear { focused = .play }
        .fullScreenCover(isPresented: $showPlayer) {
            PlayerView(item: item)
        }
    }
}
