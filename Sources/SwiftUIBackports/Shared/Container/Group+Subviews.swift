import SwiftUI

@available(iOS, deprecated: 18)
@available(tvOS, deprecated: 18)
@available(macOS, deprecated: 15)
@available(watchOS, deprecated: 11)
@available(visionOS, deprecated: 2)
extension Backport<Any> {
    /// Transforms the subviews of a given view into a resulting content view.
    ///
    /// You don't use this type directly. Instead SwiftUI creates this type on
    /// your behalf.
    public struct Group<Content: View>: View {
        private var content: Content

        /// Constructs a group from the subviews of the given view.
        ///
        /// Use this initializer to create a group that gives you programmatic
        /// access to the group's subviews. The following `CardsView` defines the
        /// group's structure based on the set of views that you provide to it:
        ///
        ///     struct CardsView<Content: View>: View {
        ///         var content: Content
        ///
        ///         init(@ContentBuilder content: () -> Content) {
        ///             self.content = content()
        ///         }
        ///
        ///         var body: some View {
        ///             VStack {
        ///                 Group(subviews: content) { subviews in
        ///                     HStack {
        ///                         if subviews.count >= 2 {
        ///                             SecondaryCard { subview[1] }
        ///                         }
        ///                         if let first = subviews.first {
        ///                             FeatureCard { first }
        ///                         }
        ///                         if subviews.count >= 3 {
        ///                             SecondaryCard { subviews[2] }
        ///                         }
        ///                     }
        ///                     if subviews.count > 3 {
        ///                         subviews[3...]
        ///                     }
        ///                 }
        ///             }
        ///         }
        ///     }
        ///
        /// You can use `CardsView` with its content builder-based initializer to
        /// arrange a collection of subviews:
        ///
        ///     CardsView {
        ///         NavigationLink("What's New!") { WhatsNewView() }
        ///         NavigationLink("Latest Hits") { LatestHitsView() }
        ///         NavigationLink("Favorites") { FavoritesView() }
        ///         NavigationLink("Playlists") { MyPlaylists() }
        ///     }
        ///
        /// Subviews collection constructs subviews on demand, so only access the
        /// part of the collection you need to create the resulting content.
        ///
        /// Subviews are proxies to the view they represent, which means
        /// that modifiers that you apply to the original view take effect before
        /// modifiers that you apply to the subview. SwiftUI resolves the view
        /// using the environment of its container rather than the environment of
        /// its subview proxy. Additionally, because subviews represent a
        /// single view or container, a subview might represent a view after the
        /// application of styles. As a result, applying a style to a subview might
        /// have no effect.
        ///
        /// - Parameters:
        ///   - view: The view to get the subviews of.
        ///   - transform: A closure that constructs a view from the collection of
        ///     subviews.
        public init<Base, Result>(
            subviews view: Base,
            @ViewBuilder transform: @escaping (SubviewsCollection) -> Result
        ) where Content == GroupElementsOfContent<Base, Result>, Base: View, Result: View {
            content = GroupElementsOfContent(view, subviews: transform)
        }

        public var body: some View {
            content
        }
    }

    /// Transforms the subviews of a given view into a resulting content view.
    ///
    /// You don't use this type directly. Instead SwiftUI creates this type on
    /// your behalf.
    public struct GroupElementsOfContent<Subviews, Content>: View, ~Sendable where Subviews: View, Content: View {
        private var content: AnyView
        private var subviews: (SubviewsCollection) -> Content

        /// Constructs a group from the subviews of the given view.
        ///
        /// Use this initializer to create a group that gives you programmatic
        /// access to the group's subviews. The following `CardsView` defines the
        /// group's structure based on the set of views that you provide to it:
        ///
        ///     struct CardsView<Content: View>: View {
        ///         var content: Content
        ///
        ///         init(@ContentBuilder content: () -> Content) {
        ///             self.content = content()
        ///         }
        ///
        ///         var body: some View {
        ///             VStack {
        ///                 Group(subviews: content) { subviews in
        ///                     HStack {
        ///                         if subviews.count >= 2 {
        ///                             SecondaryCard { subview[1] }
        ///                         }
        ///                         if let first = subviews.first {
        ///                             FeatureCard { first }
        ///                         }
        ///                         if subviews.count >= 3 {
        ///                             SecondaryCard { subviews[2] }
        ///                         }
        ///                     }
        ///                     if subviews.count > 3 {
        ///                         subviews[3...]
        ///                     }
        ///                 }
        ///             }
        ///         }
        ///     }
        ///
        /// You can use `CardsView` with its content builder-based initializer to
        /// arrange a collection of subviews:
        ///
        ///     CardsView {
        ///         NavigationLink("What's New!") { WhatsNewView() }
        ///         NavigationLink("Latest Hits") { LatestHitsView() }
        ///         NavigationLink("Favorites") { FavoritesView() }
        ///         NavigationLink("Playlists") { MyPlaylists() }
        ///     }
        ///
        /// Subviews collection constructs subviews on demand, so only access the
        /// part of the collection you need to create the resulting content.
        ///
        /// Subviews are proxies to the view they represent, which means
        /// that modifiers that you apply to the original view take effect before
        /// modifiers that you apply to the subview. SwiftUI resolves the view
        /// using the environment of its container rather than the environment of
        /// its subview proxy. Additionally, because subviews represent a
        /// single view or container, a subview might represent a view after the
        /// application of styles. As a result, applying a style to a subview might
        /// have no effect.
        ///
        /// - Parameters:
        ///   - view: The view to get the subviews of.
        ///   - transform: A closure that constructs a view from the collection of
        ///     subviews.
        public init<Source: View>(_ source: Source, @ViewBuilder subviews: @escaping (SubviewsCollection) -> Content) {
            self.content = .init(source.variadic { subviews(SubviewsCollection(children: $0)) })
            self.subviews = subviews
        }

        public var body: some View {
            content
        }
    }

    /// An opaque collection representing the subviews of view.
    ///
    /// Subviews collection constructs subviews on demand, so only access the part
    /// of the collection you need to create the resulting content.
    ///
    /// You can get access to a view's subview collection by using the
    /// ``Group/init(sectionsOf:transform:)`` initializer.
    ///
    /// The collection's elements are the pieces that make up the given view, and
    /// the collection as a whole acts as a proxy for the original view.
    public struct SubviewsCollection: RandomAccessCollection, ~Sendable {
        public typealias SubSequence = SubviewsCollectionSlice
        public typealias Iterator = IndexingIterator<SubviewsCollection>
        public typealias Indices = Range<Int>
        public typealias Index = Int
        public typealias Element = Subview

        public var startIndex: Int { children.startIndex }
        public var endIndex: Int { children.endIndex }

        public func index(before i: Int) -> Int {
            children.index(before: i)
        }

        public func index(after i: Int) -> Int {
            children.index(after: i)
        }

        public subscript(position: Int) -> Subview {
            .init(children[position])
        }

        public subscript(bounds: Range<Int>) -> SubviewsCollectionSlice {
            .init(children: children[bounds])
        }

        fileprivate let children: _VariadicView.Children

        public var body: some View {
            SwiftUI.ForEach(children, id: \.id) { $0.id($0.id) }
        }
    }

    /// A slice of a SubviewsCollection.
    public struct SubviewsCollectionSlice: RandomAccessCollection, ~Sendable {
        public typealias SubSequence = SubviewsCollectionSlice
        public typealias Element = Subview
        public typealias Iterator = IndexingIterator<SubviewsCollectionSlice>
        public typealias Indices = Range<Int>
        public typealias Index = Int

        public var startIndex: Int { children.startIndex }
        public var endIndex: Int { children.endIndex }

        public subscript(position: Int) -> Subview {
            .init(children[position])
        }

        public subscript(bounds: Range<Int>) -> SubviewsCollectionSlice {
            .init(children: children[bounds])
        }

        fileprivate let children: _VariadicView.Children.SubSequence

        public var body: some View {
            SwiftUI.ForEach(children, id: \.id) { $0 }
        }
    }
}

extension Backport<Any>.SubviewsCollection: View { }
extension Backport<Any>.SubviewsCollectionSlice: View { }
