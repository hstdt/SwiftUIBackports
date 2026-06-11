import SwiftUI
import SwiftBackports

internal extension NSItemProvider {
    func loadObject<T>(of type: T.Type) async throws -> T where T: _ObjectiveCBridgeable, T._ObjectiveCType: NSItemProviderReading, T: Sendable {
        try await withCheckedThrowingContinuation { continuation in
            _ = loadObject(ofClass: T.self) { (value: _ObjectiveCBridgeable?, error: Error?) in
                switch (value, error) {
                case let (.some(value as T), nil):
                    continuation.resume(returning: value)
                case let (_, .some(error)):
                    continuation.resume(throwing: error)
                    return
                default:
                    return
                }
            }
        }
    }
}
