# Find Something to Watch — tvOS prototype

Design challenge: *How might we help someone find something worth watching in under 60 seconds, using only a remote?*
(60s is our own design target, not an Apple benchmark.)

Three screens only:
1. **Discover** — "What are you in the mood for?" → Relax / Laugh / Thrill
2. **Recommendations** — 3 picks for that mood; focused title spelled out below
3. **Decide** — title, `1h 42m · Comedy · Relaxing`, summary, **Play** (focused) + **More info** (expands in place)

Pressing Play opens a practice player that shows **"Found in Xs · target under 60s"**, a quick way to time each test session.

## Setup (Mac)
1. Install Xcode (App Store) and open it once.
2. Install XcodeGen: `brew install xcodegen`
3. Generate the project:
   ```sh
   git clone https://github.com/olivervngsf/tvOS.git
   cd tvOS
   xcodegen generate
   open TVGallery.xcodeproj
   ```
4. Top bar in Xcode: pick an **Apple TV** simulator → press **⌘R**.

## Remote controls
| Remote | Simulator keyboard | What it does |
|---|---|---|
| Swipe | Arrow keys | Move focus (cards lift & tilt) |
| Click | Enter | Open title / press button |
| Menu / Back | Esc | Go back / close player |
| Play/Pause | Space | Play/pause in player |
| Swipe left/right in player | ←/→ | Back or forward 10s |

Tip: Simulator → **Window → Show Apple TV Remote** for an on-screen remote.

## Run on a real Apple TV
1. Same Wi-Fi as your Mac.
2. Apple TV: Settings → Remotes and Devices → Remote App and Devices.
3. Xcode: Window → Devices and Simulators → pair the Apple TV.
4. Target → Signing & Capabilities → choose your Team (free Apple ID works).
5. Pick the Apple TV as run destination → ⌘R.

## Code map
- `TVGallery/Views/DiscoverView.swift` — screen 1
- `TVGallery/Views/RecommendationsView.swift` — screen 2
- `TVGallery/Views/DecideView.swift` — screen 3
- `TVGallery/Views/PlayerView.swift` — practice player + timer badge
- `TVGallery/Models/Film.swift` — moods + sample films (edit titles here)
- `TVGallery/Models/SessionClock.swift` — 60s timer
