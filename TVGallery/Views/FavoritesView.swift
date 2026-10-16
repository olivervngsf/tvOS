import SwiftUI

struct FavoritesView: View {
    @Environment(LibraryStore.self) private var store

    private let columns = Array(repeating: GridItem(.fixed(360), spacing: 48), count: 4)

    var body: some View {
        NavigationStack {
            Group {
                if store.favorites.isEmpty {
                    ContentUnavailableView(
                        "No favorites yet",
                        systemImage: "heart",
                        description: Text("Open a title and choose Add to Favorites.")
                    )
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 60) {
                            ForEach(store.favorites) { item in
                                MediaCardView(item: item)
                            }
                        }
                        .padding(80)
                    }
                }
            }
            .navigationDestination(for: MediaItem.self) { item in
                DetailView(item: item)
            }
        }
    }
}
