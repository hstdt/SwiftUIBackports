---
name: swiftui-backports
description: Find SwiftUIBackports replacements for SwiftUI APIs unavailable on project deployment target. Use for Swift/SwiftUI availability errors, old iOS/tvOS/watchOS/macOS targets, or new SwiftUI APIs in projects that include or may add SwiftUIBackports.
---

# SwiftUI Backports

When SwiftUI API newer than deployment target, check `SwiftUIBackports` before hand-rolling or raising target.

## Workflow

1. Confirm availability issue.
   - Read diagnostic / `@available`.
   - Find deployment target in `Package.swift`, `.xcodeproj/project.pbxproj`, `.xcconfig`, target settings.

2. Check dep exists.
   - `rg -n "SwiftUIBackports|SwiftBackports" Package.swift Package.resolved .`
   - Check `.build/checkouts/SwiftUIBackports`, `.swiftpm/checkouts`, `SourcePackages/checkouts`.
   - If absent, propose `https://github.com/shaps80/SwiftUIBackports`; do not add unless asked.

3. Search actual dep source.
   - `rg -n "<NativeAPI>|<TypeName>" <SwiftUIBackports checkout>`
   - Read matching file. Confirm platform/version gates.
   - Do not rely on static API indexes; installed package source is source of truth.

4. Use normal spelling.
   - View modifiers: `.backport.foo(...)`
   - Types/views: `Backport.Foo` or `Backport<Any>.Foo`
   - Environment: `backportFoo`

5. If no match, say no backport found. Pick other compat path.

## Example

```swift
sheetContent
    .backport.presentationDetents([.medium, .large])
```
