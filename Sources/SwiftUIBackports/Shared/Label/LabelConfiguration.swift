import SwiftUI
import SwiftBackports

@available(iOS, deprecated: 17)
@available(macOS, deprecated: 14)
@available(tvOS, deprecated: 17)
@available(watchOS, deprecated: 10)
extension Backport where Wrapped == Any {

    /// The properties of a label.
    nonisolated public struct LabelStyleConfiguration: ~Sendable {
        nonisolated public struct Title: View, ~Sendable {
            let content: any View
            public var body: some View {
                AnyView(content)
            }
        }

        nonisolated public struct Icon: View, ~Sendable {
            let content: any View
            public var body: some View {
                AnyView(content)
            }
        }

        /// A description of the labeled item.
        nonisolated public let title: LabelStyleConfiguration.Title

        /// A symbolic representation of the labeled item.
        nonisolated public let icon: LabelStyleConfiguration.Icon

    }

}
