---
name: swiftui-backports
description: Find SwiftUIBackports replacements for SwiftUI APIs unavailable on a project deployment target. Use for Swift/SwiftUI compiler availability errors, old iOS/tvOS/watchOS/macOS targets, or when implementing SwiftUI app features that may benefit from SwiftUIBackports.
---

# SwiftUI Backports

When SwiftUI API is newer than the deployment target, check the bundled backport index before hand-rolling compatibility code or raising the target.

## Workflow

1. Confirm the availability need.
   - Use this for compiler availability errors, planned use of modern SwiftUI APIs, or user requests to support older OS versions.
   - Find deployment target in `Package.swift`, `.xcodeproj/project.pbxproj`, `.xcconfig`, or target settings.

2. Check whether `SwiftUIBackports` is available.
   - Search for `SwiftUIBackports`, `SwiftBackports`, or existing `.backport` usage.
   - If absent, suggest adding `https://github.com/shaps80/SwiftUIBackports` only when it fits the project. Do not add it unless asked.

3. Search the index.
   - Read `references/Backports.json` from this skill.
   - Match by `name` first, then by `kind` and `namespace`.
   - If the project has an installed `SwiftUIBackports` checkout, you may confirm against its source when uncertain.

4. Decide native vs backport.
   - If target platform is marked `unavailable`, do not suggest that backport.
   - If deployment target is lower than the entry's `deprecated` version, use or suggest the backport.
   - If deployment target is at or above `deprecated`, prefer native SwiftUI.

5. Use the discovered API.
   - View modifiers: `.backport.foo(...)`
   - Types/views: usually `Backport.Foo`; use `Backport<Any>.Foo` if the compiler needs the fully qualified namespace.
   - Environment values: use the indexed environment key, such as `@Environment(\.backportRequestReview)`.

6. If no index match exists, say no backport was found and choose another compatibility path.

Do not implement new SwiftUIBackports APIs from this skill. This is for consuming the library.

## Example

```swift
sheetContent
    .backport.presentationDetents([.medium, .large])

Backport.LabeledContent("", value: 0)

@Environment(\.backportRequestReview) private var requestReview
```
