import SwiftUI
import SwiftBackports

@available(iOS, deprecated: 16)
@available(tvOS, deprecated: 16)
@available(macOS, deprecated: 13)
@available(watchOS, deprecated: 9)
extension Backport where Wrapped == Any {

    /// The properties of a labeled content instance.
    public struct LabeledContentStyleConfiguration {
        public struct Label: View, ~Sendable {
            @EnvironmentContains(key: "LabelsHiddenKey") private var isHidden
            let content: any View

            public var body: some View {
                if !isHidden {
                    AnyView(content)
                }
            }
        }

        public struct Content: View, ~Sendable {
            let content: any View
            public var body: some View {
                AnyView(content)
            }
        }

        /// The label of the labeled content instance.
        public let label: LabeledContentStyleConfiguration.Label

        /// The content of the labeled content instance.
        public let content: LabeledContentStyleConfiguration.Content
    }

}
