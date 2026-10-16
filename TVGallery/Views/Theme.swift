import SwiftUI

enum Theme {
    static let accent = Color(red: 0.90, green: 0.10, blue: 0.16)
    static let match = Color(red: 0.27, green: 0.84, blue: 0.42)
}

/// App brand in the top-left corner.
struct Wordmark: View {
    var body: some View {
        Text("TONIGHT")
            .font(.system(size: 44, weight: .black))
            .kerning(4)
            .foregroundStyle(Theme.accent)
    }
}

/// Full-bleed art that fades to black on the left and bottom so text stays readable.
struct BackdropView: View {
    let symbol: String
    let color: Color

    var body: some View {
        ZStack {
            Color.black
            LinearGradient(
                colors: [color.opacity(0.95), color.opacity(0.35)],
                startPoint: .topTrailing,
                endPoint: .bottomLeading
            )
            Image(systemName: symbol)
                .font(.system(size: 420, weight: .bold))
                .foregroundStyle(.white.opacity(0.18))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                .padding(.trailing, 180)
            LinearGradient(
                colors: [.black, .black.opacity(0.65), .clear],
                startPoint: .leading,
                endPoint: .trailing
            )
            LinearGradient(
                colors: [.clear, .black.opacity(0.7), .black],
                startPoint: .center,
                endPoint: .bottom
            )
        }
        .ignoresSafeArea()
    }
}

extension BackdropView {
    init(film: Film) {
        self.init(symbol: film.symbol, color: film.color)
    }
}

/// "98% Match  2024  [PG]  1h 42m  [HD]"
struct FilmMetaRow: View {
    let film: Film

    var body: some View {
        HStack(spacing: 20) {
            Text("\(film.match)% Match")
                .bold()
                .foregroundStyle(Theme.match)
            Text(String(film.year))
            boxed(film.rating)
            Text(film.runtime)
            boxed("HD")
        }
        .font(.callout)
        .foregroundStyle(.white.opacity(0.85))
    }

    private func boxed(_ text: String) -> some View {
        Text(text)
            .font(.caption.bold())
            .padding(.horizontal, 10)
            .padding(.vertical, 2)
            .overlay(RoundedRectangle(cornerRadius: 6).stroke(.white.opacity(0.6), lineWidth: 2))
    }
}

/// Pill button: solid white when focused, translucent otherwise.
struct PillButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        PillLabel(configuration: configuration)
    }

    private struct PillLabel: View {
        let configuration: ButtonStyleConfiguration
        @Environment(\.isFocused) private var isFocused

        var body: some View {
            configuration.label
                .font(.headline)
                .padding(.horizontal, 48)
                .padding(.vertical, 20)
                .foregroundStyle(isFocused ? .black : .white)
                .background(
                    isFocused ? Color.white : Color.white.opacity(0.18),
                    in: RoundedRectangle(cornerRadius: 14)
                )
                .scaleEffect(configuration.isPressed ? 0.95 : (isFocused ? 1.08 : 1))
                .shadow(color: .black.opacity(isFocused ? 0.5 : 0), radius: 20, y: 10)
                .animation(.easeOut(duration: 0.15), value: isFocused)
                .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
        }
    }
}
