# AGENTS.md

When talking to Shaps, sacrifice grammar for concision.

## First Reads

Before code work, read `CONTEXT.md`. It defines project terms, API-shape expectations, availability rules, and release policy. If an ADR exists under `docs/adr/` for the area you touch, read it too.

When implementing a SwiftUI API backport, check `swiftui.ref` and `swiftuicore.ref` in the repo root for Xcode SwiftUI/SwiftUICore module interface references. Use them to confirm native signatures, overload sets, generics, availability, and hidden helper types before shaping public API.

## Project Rules

- This is a SwiftPM library, not an app.
- Main target is `SwiftUIBackports`.
- Preserve Apple SwiftUI API parity for backports: names, overloads, behavior, docs, and availability should match native APIs where practical.
- Prefer `.backport` modifiers for view/transition APIs and `Backport<Any>` for pure namespace types.
- Keep UIKit/AppKit bridge details internal/private unless public API parity demands exposure.
- Use `@available` and `#if os(...)` deliberately. Minimum floors are iOS 13, tvOS 13, watchOS 6, macOS 10.15.
- Do not move deprecated APIs casually. Deprecation shims are source-compatibility promises.
- PRs need exactly one release label: `release:major` or `release:minor`.

## Verification

- Prefer `swift build` for package-level validation.
- If changing platform-specific bridges, also reason through unsupported platforms and compile gates.
- If adding public API, include header docs matching the style of neighboring files.

## Agent skills

### Issue tracker

Issues and PRDs live in GitHub Issues for `shaps80/SwiftUIBackports`. See `docs/agents/issue-tracker.md`.

### Triage labels

Triage labels use the default five-role vocabulary; missing GitHub labels should be created before automated triage. See `docs/agents/triage-labels.md`.

### Domain docs

Single-context repo: root `CONTEXT.md` plus optional ADRs under `docs/adr/`. See `docs/agents/domain.md`.
