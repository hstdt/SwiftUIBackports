import SwiftUI

extension Backport<Any> {
    @available(iOS, deprecated: 18)
    @available(tvOS, deprecated: 18)
    @available(macOS, deprecated: 15)
    @available(watchOS, deprecated: 11)
    @available(visionOS, deprecated: 2)
    public struct ForEach<Content: View, Data, ID>: View {
        private var content: AnyView

        public init<V>(subviewOf view: V, @ViewBuilder content: @escaping (Subview) -> Content) where Data == ForEachSubviewCollection<Content>, ID == Subview.ID, Content: View, V: View {
            self.content = .init(
                view.variadic { children in
                    SwiftUI.ForEach(children) { child in
                        content(.init(child))
                    }
                }
            )
        }

        public var body: some View { content }
    }
}

extension Backport<Any> {
    @available(iOS, deprecated: 18)
    @available(tvOS, deprecated: 18)
    @available(macOS, deprecated: 15)
    @available(watchOS, deprecated: 11)
    @available(visionOS, deprecated: 2)
    public struct ForEachSubviewCollection<Content>: RandomAccessCollection, ~Sendable where Content: View {
        public typealias SubSequence = Slice<ForEachSubviewCollection<Content>>
        public typealias Iterator = IndexingIterator<ForEachSubviewCollection<Content>>
        public typealias Indices = Range<Int>
        public typealias Index = Int
        public typealias Element = Subview

        nonisolated public var startIndex: Int { children.startIndex }
        nonisolated public var endIndex: Int { children.endIndex }

        nonisolated public func index(before i: Int) -> Int {
            children.index(before: i)
        }

        nonisolated public func index(after i: Int) -> Int {
            children.index(after: i)
        }

        public subscript(index: Int) -> Subview {
            .init(children[index])
        }

        nonisolated(unsafe) fileprivate let children: _VariadicView.Children
        let content: (Subview) -> Content
    }
}
