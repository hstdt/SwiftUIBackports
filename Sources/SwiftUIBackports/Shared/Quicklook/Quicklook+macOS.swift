import SwiftUI
import SwiftBackports

#if os(macOS)
import QuickLook
import QuickLookUI

nonisolated
final class PreviewController<Items>: NSViewController, @MainActor QLPreviewPanelDataSource, QLPreviewPanelDelegate where Items: RandomAccessCollection, Items.Element == URL {
    @MainActor private let panel = QLPreviewPanel.shared()!
    @MainActor private weak var windowResponder: NSResponder?

    @MainActor
    var items: Items

    @MainActor
    var selection: Binding<Items.Element?> {
        didSet {
            updateControllerLifecycle(
                from: oldValue.wrappedValue,
                to: selection.wrappedValue
            )
        }
    }

    @MainActor
    private func updateControllerLifecycle(from oldValue: Items.Element?, to newValue: Items.Element?) {
        switch (oldValue, newValue) {
        case (.none, .some):
            present()
        case (.some, .some):
            update()
        case (.some, .none):
            dismiss()
        case (.none, .none):
            break
        }
    }

    @MainActor
    init(selection: Binding<Items.Element?>, in items: Items) {
        self.selection = selection
        self.items = items
        super.init(nibName: nil, bundle: nil)
        windowResponder = NSApp.mainWindow?.nextResponder
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @MainActor
    override func loadView() {
        view = .init(frame: .zero)
    }

    @MainActor
    var isVisible: Bool {
        QLPreviewPanel.sharedPreviewPanelExists() && panel.isVisible
    }

    @MainActor
    private func present() {
        NSApp.mainWindow?.nextResponder = self

        if isVisible {
            panel.updateController()
            let index = selection.wrappedValue.flatMap { items.firstIndex(of: $0) }
            panel.currentPreviewItemIndex = items.distance(from: items.startIndex, to: index ?? items.startIndex)
        } else {
            panel.makeKeyAndOrderFront(nil)
        }
    }

    @MainActor
    private func update() {
        present()
    }

    @MainActor
    private func dismiss() {
        selection.wrappedValue = nil
    }

    @MainActor
    func numberOfPreviewItems(in panel: QLPreviewPanel!) -> Int {
        items.isEmpty ? 1 : items.count
    }

    @MainActor
    func previewPanel(_ panel: QLPreviewPanel!, previewItemAt index: Int) -> QLPreviewItem! {
        if items.isEmpty {
            return selection.wrappedValue as? NSURL
        } else {
            let index = items.index(items.startIndex, offsetBy: index)
            return items[index] as NSURL
        }
    }

    override func acceptsPreviewPanelControl(_ panel: QLPreviewPanel!) -> Bool {
        return true
    }

    override func beginPreviewPanelControl(_ panel: QLPreviewPanel!) {
        Task { @MainActor in
            panel.dataSource = self
            panel.reloadData()
        }
    }

    override func endPreviewPanelControl(_ panel: QLPreviewPanel!) {
        Task { @MainActor in
            panel.dataSource = nil
            dismiss()
        }
    }

}

#endif
