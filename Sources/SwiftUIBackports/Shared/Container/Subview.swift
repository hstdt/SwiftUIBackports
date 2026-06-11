import SwiftUI

@available(iOS, deprecated: 18)
@available(tvOS, deprecated: 18)
@available(macOS, deprecated: 15)
@available(watchOS, deprecated: 11)
@available(visionOS, deprecated: 2)
extension Backport<Any> {
    /// An opaque value representing a subview of another view.
    ///
    /// Access to a `Subview` can be obtained by using `ForEach(subviews:)` or
    /// `Group(subviews:)`.
    ///
    /// Subviews are proxies to the resolved view they represent, meaning
    /// that modifiers applied to the original view will be applied before
    /// modifiers applied to the subview, and the view is resolved
    /// using the environment of its container, *not* the environment of the
    /// its subview proxy. Additionally, because subviews must represent a
    /// single leaf view, or container, a subview may represent a view after the
    /// application of styles. As such, attempting to apply a style to it may
    /// have no affect.
    nonisolated public struct Subview: View, Identifiable, ~Sendable {
        /// A unique identifier for a subview.
        public struct ID: Hashable, ~Sendable {
            var wrapped: AnyHashable
        }

        /// The unique identifier of the view.
        ///
        /// This identifier persists across updates, changes to the order of
        /// subviews, etc. so can be used to track the lifetime of a subview.
        public let id: ID
        private let content: _VariadicView.Children.Element

        internal init(_ content: _VariadicView.Children.Element) {
            self.id = .init(wrapped: content.id)
            self.content = content
        }

        public var body: some View {
            content
        }
    }
}
