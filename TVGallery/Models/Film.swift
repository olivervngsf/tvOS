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

    /// One-line hint under the mood label.
    var subtitle: String {
        switch self {
        case .relaxing: "Calm, cozy, easy to watch"
        case .laugh: "Light, funny, feel-good"
        case .thrill: "Tense, fast, gripping"
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
    let year: Int
    let rating: String
    let match: Int
    let minutes: Int
    let genre: String
    let mood: Mood
    let summary: String
    let starring: String
    let director: String
    let symbol: String
    let color: Color

    var runtime: String { "\(minutes / 60)h \(String(format: "%02d", minutes % 60))m" }

    /// "1h 42m · Comedy · Relaxing"
    var metaLine: String { "\(runtime) · \(genre) · \(mood.rawValue.capitalized)" }

    /// "Comedy · Relaxing"
    var tags: String { "\(genre) · \(mood.rawValue.capitalized)" }
}

extension Film {
    /// Few choices per mood on purpose: limited options = faster decisions.
    static func picks(for mood: Mood) -> [Film] {
        all.filter { $0.mood == mood }
    }

    static let all: [Film] = [
        Film(title: "Film A", year: 2024, rating: "PG", match: 98, minutes: 102,
             genre: "Comedy", mood: .relaxing,
             summary: "A lighthearted story for a quiet evening.",
             starring: "Placeholder Actor, Placeholder Actor", director: "Placeholder Director",
             symbol: "cup.and.saucer.fill", color: .indigo),
        Film(title: "Film B", year: 2023, rating: "PG", match: 94, minutes: 95,
             genre: "Drama", mood: .relaxing,
             summary: "Two friends rediscover a small seaside town.",
             starring: "Placeholder Actor, Placeholder Actor", director: "Placeholder Director",
             symbol: "water.waves", color: .teal),
        Film(title: "Film C", year: 2022, rating: "G", match: 91, minutes: 88,
             genre: "Documentary", mood: .relaxing,
             summary: "A slow, beautiful walk through mountain forests.",
             starring: "Placeholder Actor, Placeholder Actor", director: "Placeholder Director",
             symbol: "leaf.fill", color: .green),

        Film(title: "Film D", year: 2024, rating: "PG-13", match: 97, minutes: 97,
             genre: "Comedy", mood: .laugh,
             summary: "A wedding planner's worst week ever.",
             starring: "Placeholder Actor, Placeholder Actor", director: "Placeholder Director",
             symbol: "party.popper.fill", color: .orange),
        Film(title: "Film E", year: 2023, rating: "PG", match: 93, minutes: 91,
             genre: "Comedy", mood: .laugh,
             summary: "A cat inherits a bakery. Chaos follows.",
             starring: "Placeholder Actor, Placeholder Actor", director: "Placeholder Director",
             symbol: "cat.fill", color: .pink),
        Film(title: "Film F", year: 2024, rating: "G", match: 90, minutes: 104,
             genre: "Animation", mood: .laugh,
             summary: "Robots try to throw a surprise party.",
             starring: "Placeholder Actor, Placeholder Actor", director: "Placeholder Director",
             symbol: "gamecontroller.fill", color: .yellow),

        Film(title: "Film G", year: 2024, rating: "PG-13", match: 96, minutes: 118,
             genre: "Thriller", mood: .thrill,
             summary: "One night, one train, one missing passenger.",
             starring: "Placeholder Actor, Placeholder Actor", director: "Placeholder Director",
             symbol: "tram.fill", color: .red),
        Film(title: "Film H", year: 2023, rating: "PG-13", match: 92, minutes: 124,
             genre: "Sci-Fi", mood: .thrill,
             summary: "A signal from deep space starts counting down.",
             starring: "Placeholder Actor, Placeholder Actor", director: "Placeholder Director",
             symbol: "sparkles", color: .purple),
        Film(title: "Film I", year: 2022, rating: "R", match: 89, minutes: 109,
             genre: "Action", mood: .thrill,
             summary: "A getaway driver takes one last job.",
             starring: "Placeholder Actor, Placeholder Actor", director: "Placeholder Director",
             symbol: "car.fill", color: .gray),
    ]
}
