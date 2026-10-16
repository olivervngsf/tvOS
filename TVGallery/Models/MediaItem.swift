import SwiftUI

struct MediaItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let year: Int
    let genre: String
    let minutes: Int
    let symbol: String
    let color: Color
    let summary: String
}

struct MediaCategory: Identifiable {
    let id = UUID()
    let name: String
    let items: [MediaItem]
}

extension MediaItem {
    static func sample(_ title: String, _ genre: String, _ symbol: String, _ color: Color, year: Int = 2024, minutes: Int = 95) -> MediaItem {
        MediaItem(
            title: title,
            year: year,
            genre: genre,
            minutes: minutes,
            symbol: symbol,
            color: color,
            summary: "\(title) is a \(genre.lowercased()) story. Swap this text for your real description."
        )
    }
}

extension MediaCategory {
    static let samples: [MediaCategory] = [
        MediaCategory(name: "Trending Now", items: [
            .sample("Ocean Drift", "Documentary", "water.waves", .blue),
            .sample("Night Rider", "Action", "car.fill", .red),
            .sample("Star Trail", "Sci-Fi", "sparkles", .purple),
            .sample("Green Valley", "Drama", "leaf.fill", .green),
            .sample("Sun Chasers", "Adventure", "sun.max.fill", .orange),
            .sample("Frozen Peak", "Documentary", "snowflake", .cyan),
        ]),
        MediaCategory(name: "Comedy", items: [
            .sample("Laugh Track", "Comedy", "face.smiling", .yellow),
            .sample("Party Time", "Comedy", "party.popper.fill", .pink),
            .sample("Cat Cafe", "Comedy", "cat.fill", .brown),
            .sample("Game Night", "Comedy", "gamecontroller.fill", .indigo),
            .sample("Music Box", "Comedy", "music.note", .mint),
        ]),
        MediaCategory(name: "Kids", items: [
            .sample("Dino Land", "Animation", "fossil.shell.fill", .teal),
            .sample("Rocket Pals", "Animation", "airplane", .orange),
            .sample("Bunny Hop", "Animation", "hare.fill", .pink),
            .sample("Fish Friends", "Animation", "fish.fill", .blue),
            .sample("Star Bear", "Animation", "star.fill", .yellow),
        ]),
    ]
}
