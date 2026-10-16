import SwiftUI

@main
struct TVGalleryApp: App {
    @State private var store = LibraryStore()

    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView()
                    .tabItem { Label("Home", systemImage: "house") }
                FavoritesView()
                    .tabItem { Label("Favorites", systemImage: "heart") }
                SettingsView()
                    .tabItem { Label("Settings", systemImage: "gearshape") }
            }
            .environment(store)
        }
    }
}
