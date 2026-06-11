import SwiftUI
import SwiftBackports

extension Backport where Wrapped == Any {

    /// The default label style in the current context.
    ///
    /// You can also use ``LabelStyle/automatic`` to construct this style.
    public struct DefaultLabelStyle: @preconcurrency BackportLabelStyle {
        private struct Content: View {
            let configuration: Configuration
            @State private var isToolbarElement: Bool

            init(configuration: Configuration) {
                self.configuration = configuration
                _isToolbarElement = .init(initialValue: false)
            }

            var body: some View {
                if isToolbarElement {
                    IconOnlyLabelStyle().makeBody(configuration: configuration)
                } else {
                    TitleAndIconLabelStyle().makeBody(configuration: configuration)
                        #if os(iOS)
                        .ancestor(forType: UINavigationBar.self) { _ in
                            isToolbarElement = true
                        }
                        #endif
                }
            }
        }

        public init() { }

        /// Creates a view that represents the body of a label.
        ///
        /// The system calls this method for each ``Label`` instance in a view
        /// hierarchy where this style is the current label style.
        ///
        /// - Parameter configuration: The properties of the label.
        @MainActor public func makeBody(configuration: Configuration) -> some View {
            Content(configuration: configuration)
        }

    }

}

extension BackportLabelStyle where Self == Backport<Any>.DefaultLabelStyle {

    /// A label style that resolves its appearance automatically based on the
    /// current context.
    public static var automatic: Self { .init() }

}
