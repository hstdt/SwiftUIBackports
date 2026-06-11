import SwiftUI
import SwiftBackports

@available(iOS, deprecated: 16)
@available(tvOS, deprecated: 16)
@available(macOS, deprecated: 13)
@available(watchOS, deprecated: 9)
extension Backport where Wrapped: View {
    /// Sets a style for labeled content.
    public func labeledContentStyle<S>(_ style: S) -> some View where S: BackportLabeledContentStyle {
        wrapped.environment(\.backportLabeledContentStyle, style)
    }
}

@available(iOS, deprecated: 16)
@available(tvOS, deprecated: 16)
@available(macOS, deprecated: 13)
@available(watchOS, deprecated: 9)
public protocol BackportLabeledContentStyle {
    typealias Configuration = Backport<Any>.LabeledContentStyleConfiguration
    associatedtype Body: View
    @ViewBuilder func makeBody(configuration: Configuration) -> Body
}

@available(iOS, deprecated: 16)
@available(tvOS, deprecated: 16)
@available(macOS, deprecated: 13)
@available(watchOS, deprecated: 9)
internal extension EnvironmentValues {
    @Entry var backportLabeledContentStyle: any BackportLabeledContentStyle = .automatic
}

@available(iOS, deprecated: 16)
@available(tvOS, deprecated: 16)
@available(macOS, deprecated: 13)
@available(watchOS, deprecated: 9)
internal extension BackportLabeledContentStyle {
    @MainActor
    func resolve(configuration: Configuration) -> some View {
        ResolvedBackportLabeledContentStyle(configuration: configuration, style: self)
    }
}

@available(iOS, deprecated: 16)
@available(tvOS, deprecated: 16)
@available(macOS, deprecated: 13)
@available(watchOS, deprecated: 9)
private struct ResolvedBackportLabeledContentStyle<Style: BackportLabeledContentStyle>: View {
    var configuration: Backport<Any>.LabeledContentStyleConfiguration

    var style: Style

    var body: some View {
        style.makeBody(configuration: configuration)
    }
}
