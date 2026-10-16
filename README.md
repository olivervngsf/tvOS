# TV Gallery — starter Apple TV (tvOS) app

Netflix-style SwiftUI app you drive with the Siri Remote.

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
| Swipe left/right in player | ←/→ | Seek ∓10s |

Tip: Simulator → **Window → Show Apple TV Remote** for an on-screen remote.

## Run on a real Apple TV
1. Same Wi-Fi as your Mac.
2. Apple TV: Settings → Remotes and Devices → Remote App and Devices.
3. Xcode: Window → Devices and Simulators → pair the Apple TV.
4. Target → Signing & Capabilities → choose your Team (free Apple ID works).
5. Pick the Apple TV as run destination → ⌘R.

## Code map
- `TVGallery/App/TVGalleryApp.swift` — tabs: Home / Favorites / Settings
- `TVGallery/Views/HomeView.swift` — hero banner + scrolling rows
- `TVGallery/Views/MediaCardView.swift` — focusable card (`.buttonStyle(.card)`)
- `TVGallery/Views/DetailView.swift` — Play + Favorite buttons
- `TVGallery/Views/PlayerView.swift` — remote button handling
- `TVGallery/Models/` — sample data + shared store

## Next steps
- Replace `ArtworkView` with real images (`AsyncImage`).
- Swap the fake player for `AVPlayerViewController` / `VideoPlayer`.
