import Foundation
import Observation

/// Measures the design target: time from Discover to pressing Play.
@Observable
final class SessionClock {
    private(set) var start = Date.now

    var elapsedSeconds: Int { Int(Date.now.timeIntervalSince(start)) }

    func reset() { start = .now }
}
