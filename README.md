# NFSComponents

A small, self-contained SwiftUI component library: themed **buttons**, **text
fields**, **labels** and a floating **toast**. Everything ships with its own
design tokens (colors, typography, spacing, radii, shadows) and bundled fonts,
so the package has **no external dependencies** and does not read from a host
app's asset catalog.

- Platform: **iOS 15+**
- Dependencies: **none**
- Light & dark mode: **adaptive** out of the box
- Fonts: **Nunito Sans** bundled and auto-registered at runtime (SIL OFL)

## Installation

### Swift Package Manager

In Xcode: **File → Add Package Dependencies…** and enter:

```
https://github.com/Itchy-Fingerz/NFSComponents.git
```

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/Itchy-Fingerz/NFSComponents.git", from: "1.0.0")
]
```

Then import where needed:

```swift
import NFSComponents
```

## Components

### Buttons

```swift
KPKFillButton(label: "Continue") { /* tap */ }

KPKStrokeButton(label: "Cancel") { /* tap */ }

KPKFillButtonWithImg(label: "Settings", image: Image(systemName: "gear")) { }

KPKBackButton { /* optional extra action; calls dismiss() automatically */ }

@State private var isOn = false
KPKToggleButton(isTapped: $isOn) {
    // return true to allow the toggle to turn on
    true
}

@State private var agreed = false
KPKCheckButton(isTrue: $agreed, label: "I agree") { }
```

Every button accepts optional overrides (colors, height, width, corner radius)
and falls back to the theme defaults.

### Text fields

High-level, ready-to-use variants:

```swift
@State private var name = ""
KPKTextField(text: $name, placeholder: "Full name")

@State private var password = ""
KPKSecureField(password: $password, placeholder: "Password")

@State private var query = ""
KPKSearchField(searchText: $query, placeholder: "Search")

@State private var otp = ""
KPKOTPField(otp: $otp, isError: false)

@State private var picked = ""
KPKDropDownField(selectedValue: $picked,
                 placeholder: "Pick one",
                 dropDownValues: ["A", "B", "C"])

@State private var dateText = ""
@State private var date = Date()
KPKDatePickerField(selectedDate: $dateText, inDateFormat: $date, placeholder: "Date")

KPKTextFieldWithIcon(text: $name,
                     placeholder: "Username",
                     icon: Icon(type: .systemName, name: "person"))

KPKSecureFieldWithIcon(password: $password,
                       placeholder: "Password",
                       icon: Icon(type: .systemName, name: "lock"))

@State private var notes = ""
KPKLongTextField(longText: $notes, placeholder: "Notes")
```

Need full control? Drop down to the underlying `Textfield`, which takes a
`TextFieldConfigration` and a `TextFieldStyle`:

```swift
Textfield(
    text: $name,
    placeholder: "Custom",
    configration: TextFieldConfigration(placeholderType: .floating, cornerRadius: 12),
    style: TextFieldStyle(unfocusedborderColor: .gray, fillColor: .white)
)
```

> Note: the package exposes its own `Textfield` / `TextFieldStyle` types. If you
> also `import SwiftUI` and reference `TextFieldStyle` unqualified, disambiguate
> with `NFSComponents.TextFieldStyle`.

### Labels

```swift
RequiredFieldLabel(title: "Email")   // "Email *" with a red asterisk
```

### Toast

Attach the host once near the root of your app, then trigger it anywhere:

```swift
struct RootView: View {
    var body: some View {
        ContentView()
            .toastBanner()          // attach once
    }
}

// Anywhere in your code:
ToastState.show(type: .success, body: "Saved!")
ToastState.show(type: .failure, heading: "Error", body: "Something went wrong")
```

Toast types: `.info`, `.success`, `.failure`, `.warning`. Icons use SF Symbols,
so no image assets are required.

## Theming

The package ships an internal design system (`Theme`) used to style the
components. To keep it drop-in compatible with host apps that already define
their own `Theme` / `Color(hex:)` / `UIDevice.isIPhone`, those helpers are kept
**internal** — importing NFSComponents will not collide with your own.

The adaptive color tokens are exposed publicly on `Color` and can be used to
recolor components or match your palette:

```swift
Color.nfsSecondary
Color.nfsIcon
Color.nfsTextBW
Color.nfsBackgroundElevated
// …all `Color.nfs*` tokens adapt automatically to light/dark mode.

KPKFillButton(label: "Save", backgroundColor: .nfsSecondary) { }
```

## Fonts

Nunito Sans is bundled and registered with Core Text the first time any
NFSComponents typography is used — no `Info.plist` setup required in the host
app. The fonts are licensed under the SIL Open Font License 1.1 (see
`Sources/NFSComponents/Resources/Fonts/OFL.txt`).

## License

MIT — see [LICENSE](LICENSE).
