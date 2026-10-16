import SwiftUI

enum Mood: String, CaseIterable, Identifiable, Hashable {
    case relaxing, laugh, thrill

    var id: String { rawValue }

    /// Short label on the Discover card.
    var label: String {
        switch self {
        case .relaxing: "Relax"
        case .laugh: "Laugh"
        case .thrill: "Thrill"
        }
    }

    /// Heading on the Recommendations screen.
    var heading: String {
        switch self {
        case .relaxing: "For a relaxing evening"
        case .laugh: "For a good laugh"
        case .thrill: "For the edge of your seat"
        }
    }

    var symbol: String {
        switch self {
        case .relaxing: "moon.stars.fill"
        case .laugh: "face.smiling.inverse"
        case .thrill: "bolt.fill"
        }
    }

    var color: Color {
        switch self {
        case .relaxing: .indigo
        case .laugh: .orange
        case .thrill: .red
        }
    }
}

struct Film: Identifiable, Hashable {
    var id: String { title }
    let title: String
    let minutes: Int
    let genre: String
    let mood: Mood
    let summary: String
    let details: String
    let symbol: String
    let color: Color

    var runtime: String { "\(minutes / 60)h \(String(format: "%02d", minutes % 60))m" }

    /// "1h 42m · Comedy · Relaxing"
    var metaLine: String { "\(runtime) · \(genre) · \(mood.rawValue.capitalized)" }
}

extension Film {
    /// Few choices per mood on purpose: limited options = faster decisions.
    static func picks(for mood: Mood) -> [Film] {
        all.filter { $0.mood == mood }
    }

    static let all: [Film] = [
        Film(title: "Film A", minutes: 102, genre: "Comedy", mood: .relaxing,
             summary: "A lighthearted story for a quiet evening.",
             details: "Director: Placeholder · Cast: Placeholder, Placeholder · 2024 · PG",
             symbol: "cup.and.saucer.fill", color: .indigo),
        Film(title: "Film B", minutes: 95, genre: "Drama", mood: .relaxing,
             summary: "Two friends rediscover a small seaside town.",
             details: "Director: Placeholder · Cast: Placeholder · 2023 · PG",
             symbol: "water.waves", color: .teal),
        Film(title: "Film C", minutes: 88, genre: "Documentary", mood: .relaxing,
             summary: "A slow, beautiful walk through mountain forests.",
             details: "Narrator: Placeholder · 2022 · G",
             symbol: "leaf.fill", color: .green),

        Film(title: "Film D", minutes: 97, genre: "Comedy", mood: .laugh,
             summary: "A wedding planner's worst week ever.",
             details: "Director: Placeholder · Cast: Placeholder · 2024 · PG-13",
             symbol: "party.popper.fill", color: .orange),
        Film(title: "Film E", minutes: 91, genre: "Comedy", mood: .laugh,
             summary: "A cat inherits a bakery. Chaos follows.",
             details: "Director: Placeholder · Cast: Placeholder · 2023 · PG",
             symbol: "cat.fill", color: .pink),
        Film(title: "Film F", minutes: 104, genre: "Animation", mood: .laugh,
             summary: "Robots try to throw a surprise party.",
             details: "Director: Placeholder · Voices: Placeholder · 2024 · G",
             symbol: "gamecontroller.fill", color: .yellow),

        Film(title: "Film G", minutes: 118, genre: "Thriller", mood: .thrill,
             summary: "One night, one train, one missing passenger.",
             details: "Director: Placeholder · Cast: Placeholder · 2024 · PG-13",
             symbol: "tram.fill", color: .red),
        Film(title: "Film H", minutes: 124, genre: "Sci-Fi", mood: .thrill,
             summary: "A signal from deep space starts counting down.",
             details: "Director: Placeholder · Cast: Placeholder · 2023 · PG-13",
             symbol: "sparkles", color: .purple),
        Film(title: "Film I", minutes: 109, genre: "Action", mood: .thrill,
             summary: "A getaway driver takes one last job.",
             details: "Director: Placeholder · Cast: Placeholder · 2022 · R",
             symbol: "car.fill", color: .gray),
    ]
}
