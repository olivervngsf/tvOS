import SwiftUI

/// A poster card. `.buttonStyle(.card)` gives the native tvOS focus lift, tilt and shine.
struct MediaCardView: View {
    let item: MediaItem

    var body: some View {
        NavigationLink(value: item) {
            VStack(alignment: .leading, spacing: 0) {
                ArtworkView(item: item)
                    .frame(width: 360, height: 210)
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title)
                        .font(.headline)
                        .lineLimit(1)
                    Text("\(item.genre) · \(String(item.year))")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(16)
                .frame(width: 360, alignment: .leading)
            }
        }
        .buttonStyle(.card)
    }
}
