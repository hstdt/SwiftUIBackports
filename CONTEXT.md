# SwiftUIBackports Context

SwiftUIBackports is a Swift Package Manager library that provides SwiftUI API backports for older Apple platform versions. The goal is API familiarity: callers should use names, shape, and behavior that match Apple's SwiftUI APIs wherever practical, while implementations bridge onto older platform primitives.

## Glossary

| Term | Meaning |
| --- | --- |
| Backport | A compatibility implementation of a newer SwiftUI API for older supported OS versions. Prefer API parity over novel behavior. |
| `Backport` namespace | The generic namespace type supplied by `SwiftBackports`. This package extends it with SwiftUI APIs. |
| `.backport` | The discovery point for view and transition modifiers, e.g. `view.backport.presentationDetents(...)`. |
| `Backport<Any>` | Namespace form used for pure backported types that are not tied to a wrapped view, such as `Backport<Any>.PresentationDetent`. |
| API parity | Matching Apple's public API names, overloads, documentation intent, and availability as closely as this package can. |
| Additional API | Functionality that is not an Apple API match. Keep it separate and named clearly so it does not blur API parity. |
| Environment backport | A backported environment value. These usually use a `backport` prefix because environment values cannot always sit naturally under `.backport`. |
| Shared backport | A backport under `Sources/SwiftUIBackports/Shared`, intended for multiple Apple platforms unless guarded otherwise. |
| Platform-specific backport | A backport under a platform folder such as `iOS`, used where behavior depends on UIKit/AppKit or only exists on that platform family. |
| Representable bridge | A `UIViewRepresentable`, `UIViewControllerRepresentable`, `NSViewRepresentable`, or controller/view wrapper used to reach platform APIs behind a SwiftUI surface. |
| Availability fence | `@available` and `#if os(...)` gating that keeps APIs visible on the intended platform/version set and directs users to Apple's native APIs after deprecation. |
| Deprecation shim | A compatibility surface kept only to move users toward a renamed API, a different package, or Apple's native API. |
| Minimum platform floor | Package support floor: iOS 13, tvOS 13, watchOS 6, macOS 10.15. |
| Native API | The official Apple SwiftUI API being mirrored. When a native API is available, deprecation should point users there. |
| Demo project | Separate repository, `SwiftUIBackportsDemo`, used for demonstrations rather than source ownership in this package. |
| Release label | Pull requests must carry exactly one of `release:major` or `release:minor` for release automation. Both labels already exist on GitHub. |

## Project Shape

- Package target: `SwiftUIBackports`.
- Main source root: `Sources/SwiftUIBackports`.
- Public namespace entry: `Sources/SwiftUIBackports/Backport.swift`.
- Shared APIs live under `Sources/SwiftUIBackports/Shared`.
- iOS-specific APIs live under `Sources/SwiftUIBackports/iOS`.
- Internal helpers live under `Sources/SwiftUIBackports/Internal`.
- Deprecated/moved surfaces live under `Sources/SwiftUIBackports/Deprecations`.
- Privacy manifest lives at `Sources/SwiftUIBackports/Resources/PrivacyInfo.xcprivacy`.

## Design Rules

- Prefer Apple's API spelling and overload shape. Do not invent alternate names for parity APIs.
- Keep compatibility implementation details private unless public API parity requires exposure.
- Use `@available` to communicate native API replacement versions and unsupported platform cases.
- Gate UIKit/AppKit implementation with compile-time checks so non-owning platforms keep compiling.
- Keep old OS behavior graceful. If an underlying platform feature does not exist, preserve the SwiftUI call surface and no-op or degrade only when that matches project precedent.
- Public docs should read like SwiftUI docs. Existing files often mirror Apple documentation for consistency.
- Avoid adding dependencies unless they are necessary for a backport and fit SwiftPM library use.

## Build And Release

- Swift tools version: 5.7.
- Swift language mode: Swift 5.
- Dependency: `SwiftBackports` from `https://github.com/shaps80/SwiftBackports`.
- Documentation plugin: `swift-docc-plugin`.
- Release automation requires PRs to have exactly one release label: `release:major` or `release:minor`.
- Merged release-labeled PRs to `main` create and push the next semantic version tag.

## Open Questions

- Test strategy is not documented in-repo yet.
- Triage labels beyond `wontfix` are not currently present in GitHub labels.
