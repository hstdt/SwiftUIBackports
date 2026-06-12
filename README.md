![watchOS](https://img.shields.io/badge/watchOS-DE1F51)
![macOS](https://img.shields.io/badge/macOS-EE751F)
![tvOS](https://img.shields.io/badge/tvOS-00B9BB)
![ios](https://img.shields.io/badge/iOS-0C62C7)
[![swift](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fshaps80%2FSwiftUIBackports%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/shaps80/SwiftUIBackports)

# SwiftUI Backports

Use modern SwiftUI APIs while still supporting older Apple platforms.

SwiftUIBackports mirrors Apple's SwiftUI API names, shapes, behavior, documentation, and availability where practical. This keeps app code familiar today, and easy to migrate away from once your deployment target reaches the native API.

Backports are discovered through `.backport`, the `Backport` namespace, or `backport`-prefixed environment values. The package also includes a machine-readable index and agent skill to help developers and coding agents find the right compatibility API quickly.

Additional APIs, when present, are kept separate from Apple API-matching backports.

This repo can also serve as a reference for building practical SwiftUI backports with minimal hacks.

> [!CAUTION]
> From v27, SwiftUIBackports will require iOS 15+, macOS 12+, tvOS 15+, and watchOS 8+. If you need to support older platform versions, remain on 26.2.0.

> [!NOTE]
> Using an agent? Install the bundled discovery skill so coding agents can find available backports automatically:
>
> ```sh
> npx skills add shaps80/SwiftUIBackports
> ```

## Sponsor

Building useful libraries like these, takes time away from my family. I build these tools in my spare time because I feel its important to give back to the community. Please consider [Sponsoring](https://github.com/sponsors/shaps80) me as it helps keep me working on useful libraries like these 😬

You can also give me a follow and a 'thanks' anytime.

[![Twitter](https://img.shields.io/badge/Twitter-@shaps-4AC71B)](http://twitter.com/shaps)

## Usage

SwiftUIBackports mirrors Apple's SwiftUI APIs where practical, while keeping backported APIs easy to find and remove once your deployment target reaches the native API.

View modifiers are available from `.backport`:

```swift
sheetContent
    .backport.presentationDetents([.medium, .large])
```

Backported types are usually available from the `Backport` namespace:

```swift
Backport.LabeledContent("", value: 0)
```

If the compiler needs the fully-qualified namespace, use `Backport<Any>`:

```swift
Backport<Any>.LabeledContent("", value: 0)
```

Environment backports use a `backport` prefix:

```swift
@Environment(\.backportRequestReview) private var requestReview
```

## Backports

The supported backports are indexed in:

```text
skills/swiftui-backports/references/Backports.jsonl
```

The line-oriented index lists implemented backports, their kind, source location, and platform availability. Prefer this index over static README examples, which get stale quickly.

This repository also includes an agent skill:

```text
skills/swiftui-backports/SKILL.md
```

Use that skill when working in an app that targets older Apple OS versions, or when a compiler availability error blocks use of a newer SwiftUI API. The skill tells agents to:

- check the project deployment target
- search the bundled backport index
- prefer native SwiftUI when the deployment target is new enough
- use `.backport`, `Backport`, or `backport` environment keys when a matching backport exists

## Extras

**Modal Presentations**

Adding this to your presented view, you can use the provided closure to present an `ActionSheet` to a user when they attempt to dismiss interactively. You can also use this to disable interactive dismissals entirely.

```swift
presentation(isModal: true) { /* attempt */ }
```

**FittingGeometryReader**

A custom `GeometryReader` implementation that correctly auto-sizes itself to its content. This is useful in many cases where you need a `GeometryReader` but don't want it to implicitly take up its parent View's bounds.

**FittingScrollView**

A custom `ScrollView` that respects `Spacer`'s when the content is not scrollable. This is useful when you need to place a view at the edges of your scrollview while its content is small enough to not require scrolling. Another great use case is vertically centered content that becomes `top` aligned once the content requires scrolling.

## Installation

You can install manually (by copying the files in the `Sources` directory) or using Swift Package Manager (**preferred**)

To install using Swift Package Manager, add this to the `dependencies` section of your `Package.swift` file:

`.package(url: "https://github.com/shaps80/SwiftUIBackports.git", .upToNextMajor(from: "2.0.0"))`
