import SwiftUI
import SwiftBackports

extension Backport where Wrapped == Any {

    /// A label style that only displays the icon of the label.
    ///
    /// You can also use ``LabelStyle/iconOnly`` to construct this style.
    public struct IconOnlyLabelStyle: BackportLabelStyle {

        /// Creates an icon-only label style.
        public init() { }

        /// Creates a view that represents the body of a label.
        ///
        /// The system calls this method for each ``Label`` instance in a view
        /// hierarchy where this style is the current label style.
        ///
        /// - Parameter configuration: The properties of the label.
        public func makeBody(configuration: Configuration) -> some View {
            configuration.icon
        }

    }

}

extension BackportLabelStyle where Self == Backport<Any>.IconOnlyLabelStyle {

    /// A label style that only displays the icon of the label.
    ///
    /// The title of the label is still used for non-visual descriptions, such as
    /// VoiceOver.
    public static var iconOnly: Self { .init() }

}
