import SwiftUI

struct HomeView: View {
    @Environment(LibraryStore.self) private var store

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 50) {
                    HeroBanner(item: store.featured)

                    ForEach(store.categories) { category in
                        CategoryRow(category: category)
                    }
                }
                .padding(.vertical, 40)
            }
            .navigationDestination(for: MediaItem.self) { item in
                DetailView(item: item)
            }
        }
    }
}

private struct HeroBanner: View {
    let item: MediaItem

    var body: some View {
        NavigationLink(value: item) {
            ZStack(alignment: .bottomLeading) {
                ArtworkView(item: item, symbolSize: 200)
                    .frame(height: 420)
                VStack(alignment: .leading, spacing: 8) {
                    Text("FEATURED")
                        .font(.caption.bold())
                        .foregroundStyle(.white.opacity(0.8))
                    Text(item.title)
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)
                    Text("\(item.genre) · \(String(item.year)) · \(item.minutes) min")
                        .foregroundStyle(.white.opacity(0.85))
                }
                .padding(40)
            }
        }
        .buttonStyle(.card)
        .padding(.horizontal, 80)
    }
}

private struct CategoryRow: View {
    let category: MediaCategory

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(category.name)
                .font(.title3.bold())
                .padding(.horizontal, 80)

            ScrollView(.horizontal) {
                LazyHStack(spacing: 48) {
                    ForEach(category.items) { item in
                        MediaCardView(item: item)
                    }
                }
                .padding(.horizontal, 80)
                .padding(.vertical, 30) // room for the focus lift
            }
            .scrollClipDisabled()
        }
        // Remembers last focused card per row when moving up/down.
        .focusSection()
    }
}
