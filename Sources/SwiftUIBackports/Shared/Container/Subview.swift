import SwiftUI

@available(iOS, deprecated: 18)
@available(tvOS, deprecated: 18)
@available(macOS, deprecated: 15)
@available(watchOS, deprecated: 11)
@available(visionOS, deprecated: 2)
extension Backport<Any> {
    nonisolated public struct Subview: View, Identifiable, ~Sendable {
        public struct ID: Hashable, ~Sendable {
            var wrapped: AnyHashable
        }

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
