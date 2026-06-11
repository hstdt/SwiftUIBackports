import SwiftUI
import SwiftBackports

extension Backport where Wrapped == Any {

    public struct AutomaticLabeledContentStyle: @preconcurrency BackportLabeledContentStyle {
        private struct Content: View {
            @EnvironmentContains(key: "LabelsHiddenKey") private var isHidden
            let configuration: Configuration

            var body: some View {
                if isHidden {
                    configuration.content
                } else {
                    HStack(alignment: .firstTextBaseline) {
                        configuration.label
                        Spacer()
                        configuration.content
                            .foregroundColor(.secondary)
                    }
                }
            }
        }

        @MainActor public func makeBody(configuration: Configuration) -> some View {
            Content(configuration: configuration)
        }
    }

}

extension BackportLabeledContentStyle where Self == Backport<Any>.AutomaticLabeledContentStyle {
    static var automatic: Self { .init() }
}
