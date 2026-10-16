import SwiftUI

struct SettingsView: View {
    @Environment(LibraryStore.self) private var store

    var body: some View {
        @Bindable var store = store

        NavigationStack {
            List {
                Section("Playback") {
                    Toggle("Autoplay", isOn: $store.autoplay)
                    Toggle("Subtitles", isOn: $store.showSubtitles)
                }
                Section("Library") {
                    Button("Clear Favorites (\(store.favoriteIDs.count))", role: .destructive) {
                        store.favoriteIDs.removeAll()
                    }
                }
            }
            .frame(maxWidth: 1000)
        }
    }
}
