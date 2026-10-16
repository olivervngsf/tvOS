import Observation

@Observable
final class LibraryStore {
    var categories: [MediaCategory] = MediaCategory.samples
    var favoriteIDs: Set<MediaItem.ID> = []
    var autoplay = true
    var showSubtitles = false

    var featured: MediaItem { categories[0].items[0] }

    var favorites: [MediaItem] {
        categories.flatMap(\.items).filter { favoriteIDs.contains($0.id) }
    }

    func isFavorite(_ item: MediaItem) -> Bool {
        favoriteIDs.contains(item.id)
    }

    func toggleFavorite(_ item: MediaItem) {
        if favoriteIDs.contains(item.id) {
            favoriteIDs.remove(item.id)
        } else {
            favoriteIDs.insert(item.id)
        }
    }
}
