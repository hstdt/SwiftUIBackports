import SwiftUI
import SwiftBackports

#if os(iOS)
#if canImport(UniformTypeIdentifiers)
import UniformTypeIdentifiers
#endif

@available(iOS, deprecated: 16)
public extension Backport where Wrapped == Any {
    /// A system button that reads items from the pasteboard and delivers it to a
    /// closure.
    ///
    /// Use a paste button when you want to provide a button for pasting items from
    /// the system pasteboard into your app. The system provides a button
    /// appearance and label appropriate to the current environment. However, you
    /// can use view modifiers like, `labelStyle(_:)` to customize the button
    /// in some contexts.
    ///
    /// In the following example, a paste button declares that it accepts a string.
    /// When the user taps or clicks the button, the sample's closure receives an
    /// array of strings and sets the first as the value of `pastedText`, which
    /// updates a nearby `Text` view.
    ///
    ///     @State private var pastedText: String = ""
    ///
    ///     var body: some View {
    ///         HStack {
    ///             PasteButton(payloadType: String.self) { strings in
    ///                 pastedText = strings[0]
    ///             }
    ///             Divider()
    ///             Text(pastedText)
    ///             Spacer()
    ///         }
    ///     }
    ///
    /// A paste button automatically validates and invalidates based on changes to
    /// the pasteboard on iOS, but not on macOS.
    nonisolated struct PasteButton: View, ~Sendable {
        /// Creates an instance that accepts values of the specified type.
        /// - Parameters:
        ///   - type: The type that you want to paste via the `PasteButton`.
        ///   - onPaste: The handler to call on trigger of the button with at least
        ///     one item of the specified `Transferable` type from the pasteboard.
        nonisolated public init<T>(payloadType: T.Type, onPaste: @escaping ([T]) -> Void) where T: _ObjectiveCBridgeable, T._ObjectiveCType: NSItemProviderReading {
            self.canPaste = {
                UIPasteboard.general.itemProviders.contains { $0.canLoadObject(ofClass: T.self) }
            }

            self.onPaste = PasteAction {
                let providers = UIPasteboard.general.itemProviders.filter {
                    $0.canLoadObject(ofClass: T._ObjectiveCType.self)
                }

                guard !providers.isEmpty else { return }

                let coordinator = PasteCoordinator(count: providers.count, onPaste: onPaste)
                let complete = PasteCompletion { object in
                    coordinator.complete(with: object)
                }

                for provider in providers {
                    _ = provider.loadObject(ofClass: T._ObjectiveCType.self) { object, error in
                        if let error {
                            print(error)
                        }

                        complete(with: object)
                    }
                }
            }
        }

        /// Creates a Paste button that accepts specific types of data from the
        /// pasteboard.
        ///
        /// Set the contents of `supportedContentTypes` in order of your app's
        /// preference for its supported types. The Paste button takes the
        /// most-preferred type that the pasteboard source supports and delivers
        /// this to the `payloadAction` closure.
        ///
        /// - Parameters:
        ///   - supportedContentTypes: The exact uniform type identifiers supported
        ///     by the button. If the pasteboard doesn't contain any of the
        ///     supported types, the button becomes disabled.
        ///   - payloadAction: The handler to call when the user clicks the Paste
        ///     button and the pasteboard has items that conform to
        ///     `supportedContentTypes`. This closure receives an array of
        ///     item providers that you use to inspect and load the pasteboard data.
        @available(iOS, introduced: 14, deprecated: 15)
        @available(macOS, introduced: 11, deprecated: 12)
        public init(supportedContentTypes: [UTType], payloadAction: @escaping ([NSItemProvider]) -> Void) {
            self.init(supportedContentTypes: supportedContentTypes.map { $0.identifier }, payloadAction: payloadAction)
        }

        public init(supportedContentTypes: [UniformTypeIdentifiers.UTType], payloadAction: @escaping ([NSItemProvider]) -> Void) {
            self.init(supportedContentTypes: supportedContentTypes.map { $0.identifier }, payloadAction: payloadAction)
        }

        /// Creates a Paste button that accepts specific types of data from the
        /// pasteboard.
        ///
        /// Set the contents of `supportedContentTypes` in order of your app's
        /// preference for its supported types. The Paste button takes the
        /// most-preferred type that the pasteboard source supports and delivers
        /// this to the `payloaAction` closure.
        ///
        /// - Note: This initializer is provided purely to support iOS 13 clients.
        /// When possible you should use the `UTType` variant.
        ///
        /// - Parameters:
        ///   - supportedContentTypes: The exact uniform type identifiers supported
        ///     by the button. If the pasteboard doesn't contain any of the
        ///     supported types, the button becomes disabled.
        ///     `supportedContentTypes`. This closure receives an array of
        ///     item providers that you use to inspect and load the pasteboard data.
        ///   - payloadAction: The handler to call when the user clicks the Paste
        ///     button and the pasteboard has items that conform to
        public init(supportedContentTypes: [String], payloadAction: @escaping ([NSItemProvider]) -> Void) {
            canPaste = { UIPasteboard.general.contains(pasteboardTypes: supportedContentTypes) }
            onPaste = PasteAction {
                if UIPasteboard.general.contains(pasteboardTypes: supportedContentTypes) {
                    payloadAction(UIPasteboard.general.itemProviders)
                }
            }
        }

        private let canPaste: () -> Bool
        private let onPaste: PasteAction
        private let title: String = "Paste"
        private let systemImage: String = "doc.on.clipboard"

        @State private var isEnabled: Bool = false

        public var body: some View {
            let canPaste = canPaste
            let onPaste = onPaste

            Button {
                onPaste()
            } label: {
                Label(title, systemImage: systemImage)
            }
            .buttonStyle(PasteButtonStyle())
            .disabled(isEnabled)
            .onAppear { isEnabled = !canPaste() }
            .onReceive(NotificationCenter.default.publisher(for: UIPasteboard.changedNotification)) { _ in
                isEnabled = !canPaste()
            }
        }
    }
}

struct PasteButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        if #available(iOS 15, *) {
            Button {
                configuration.trigger()
            } label: {
                configuration.label
            }
            .buttonStyle(.borderedProminent)
        } else {
            Button {
                configuration.trigger()
            } label: {
                configuration.label
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .backport.background {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(.tint)
                    }
            }
        }
    }
}
#endif

private struct PasteAction: @unchecked Sendable {
    let action: () -> Void

    func callAsFunction() {
        action()
    }
}

private struct PasteCompletion: @unchecked Sendable {
    let action: ((any NSItemProviderReading)?) -> Void

    func callAsFunction(with value: (any NSItemProviderReading)?) {
        action(value)
    }
}

private final class PasteCoordinator<Wrapped>: @unchecked Sendable where Wrapped: _ObjectiveCBridgeable, Wrapped._ObjectiveCType: NSItemProviderReading {
    private let lock = NSLock()
    private var result: [Wrapped] = []
    private var remaining: Int
    private let onPaste: ([Wrapped]) -> Void

    init(count: Int, onPaste: @escaping ([Wrapped]) -> Void) {
        self.remaining = count
        self.onPaste = onPaste
    }

    func complete(with value: (any NSItemProviderReading)?) {
        lock.lock()
        if let value = value as? Wrapped {
            result.append(value)
        }

        remaining -= 1
        let isComplete = remaining == 0
        lock.unlock()

        if isComplete {
            DispatchQueue.main.async {
                self.onPaste(self.result)
            }
        }
    }
}

