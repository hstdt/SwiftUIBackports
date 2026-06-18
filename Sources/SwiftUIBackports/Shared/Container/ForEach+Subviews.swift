import SwiftUI

@available(iOS, deprecated: 18)
@available(tvOS, deprecated: 18)
@available(macOS, deprecated: 15)
@available(watchOS, deprecated: 11)
@available(visionOS, deprecated: 2)
extension Backport<Any> {
    /// A structure that computes views on demand from an underlying collection of
    /// identified data.
    public struct ForEach<Content: View, Data, ID>: View {
        private var content: AnyView

        /// Creates an instance that uniquely identifies and creates views across
        /// updates based on the subviews of a given view.
        ///
        /// Subviews are proxies to the resolved view they represent, meaning
        /// that modifiers applied to the original view will be applied before
        /// modifiers applied to the subview, and the view is resolved
        /// using the environment of its container, *not* the environment of the
        /// its subview proxy. Additionally, because subviews must represent a
        /// single leaf view, or container, a subview may represent a view after the
        /// application of styles. As such, attempting to apply a style to it may
        /// have no effect.
        ///
        /// - Parameters:
        ///   - view: The view to extract the subviews of.
        ///   - content: The content builder that creates views from subviews.
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

@available(iOS, deprecated: 18)
@available(tvOS, deprecated: 18)
@available(macOS, deprecated: 15)
@available(watchOS, deprecated: 11)
@available(visionOS, deprecated: 2)
extension Backport<Any> {
    /// A collection which allows a view to be treated as a collection of its
    /// subviews in a for each loop.
    public struct ForEachSubviewCollection<Content>: RandomAccessCollection where Content: View {
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
