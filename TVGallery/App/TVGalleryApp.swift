import SwiftUI

@main
struct TVGalleryApp: App {
    @State private var clock = SessionClock()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                DiscoverView()
                    .navigationDestination(for: Mood.self) { mood in
                        RecommendationsView(mood: mood)
                    }
                    .navigationDestination(for: Film.self) { film in
                        DecideView(film: film)
                    }
            }
            .environment(clock)
            .preferredColorScheme(.dark)
            .tint(Theme.accent)
        }
    }
}
