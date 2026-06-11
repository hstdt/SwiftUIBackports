import SwiftUI
@_exported import SwiftBackports

public extension View {
    /// Wraps a SwiftUI `View` that can be extended to provide backport functionality.
    nonisolated var backport: Backport<Self> {
        .init(self)
    }
}

public extension AnyTransition {
    /// Wraps an `AnyTransition` that can be extended to provide backport functionality.
    nonisolated static var backport: Backport<Self> {
        .init(.identity)
    }
}
