import SwiftUI
import SwiftBackports

@available(iOS, deprecated: 16)
@available(tvOS, deprecated: 16)
@available(macOS, deprecated: 13)
@available(watchOS, deprecated: 9)
extension EnvironmentValues {
    /// The visiblity to apply to scroll indicators of any
    /// vertically scrollable content.
    @Entry public var backportVerticalScrollIndicatorVisibility: Backport<Any>.ScrollIndicatorVisibility = .automatic

    /// The visibility to apply to scroll indicators of any
    /// horizontally scrollable content.
    @Entry public var backportHorizontalScrollIndicatorVisibility: Backport<Any>.ScrollIndicatorVisibility = .automatic

    /// The way that scrollable content interacts with the software keyboard.
    ///
    /// The default value is ``Backport.ScrollDismissesKeyboardMode.automatic``. Use the
    /// ``View.backport.scrollDismissesKeyboard(_:)`` modifier to configure this
    /// property.
    @Entry public var backportScrollDismissesKeyboardMode: Backport<Any>.ScrollDismissesKeyboardMode = .automatic

    /// A Boolean value that indicates whether any scroll views associated
    /// with this environment allow scrolling to occur.
    ///
    /// The default value is `true`. Use the ``View.backport.scrollDisabled(_:)``
    /// modifier to configure this property.
    @Entry public var backportIsScrollEnabled: Bool = true
}
