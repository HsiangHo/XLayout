//
//  AppDelegate.swift
//  XLayoutDemo
//
//  Created by Jovi on 7/3/19.
//  Copyright © 2019 Jovi. All rights reserved.
//

// swiftlint:disable line_length
import Cocoa
import XLayout

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    let tableView = NSTableView()
    let demoArray: [(String, String)] = [("TITLE1", "A text field does not handling editing, as such. When a text field has focus, a text view is added to the window, overlapping the area of the text field. This is called the \"field editor\" and it is responsible for handling editing. It seems the most likely place for you to change the behavior of a double-click is in the text storage object used by that text view. NSTextStorage inherits from NSMutableAttributedString which inherits from NSAttributedString which has a -doubleClickAtIndex: method. That method returns the range of the text that should be selected by a double-click at a particular index. So, you'll want to implement a subclass of NSTextStorage that overrides that method and returns a different result in some circumstances. NSTextStorage is a semi-abstract base class of a class cluster. Subclassing it requires a bit more than usual. You have to implement the primitive methods of NSAttributedString and NSMutableAttributedString. See the docs about it. There are a few places to customize the field editor by replacing its text storage object with an instance of your class: You could implement a custom subclass of NSTextFieldCell. Set your text field to use this as its cell. In your subclass, override -fieldEditorForView:. In your override, instantiate an NSTextView. Obtain its layoutManager and call -replaceTextStorage: on that, passing it an instance of your custom text storage class. (This is easier than putting together the hierarchy of objects that is involved with text editing, although you could do that yourself.) Set the fieldEditor property of the text view to true and return it. In your window delegate, implement -windowWillReturnFieldEditor:toObject:. Create, configure, and return an NSTextView using your custom text storage, as above."), ("TITLE2", "If, for instance, you have a special attachment cell that can follow links, you can use this method to ask the text view to follow a link once you decide it should. In addition, this method is invoked by the text view during mouse tracking if the user clicks a link."), ("TITLE3", "NSTextView is the principal means to obtain a text object that caters to almost all needs for displaying and managing text at the user interface level. While NSTextView is a subclass of the NSText class—which declares the most general Cocoa interface to the text system—NSTextView adds major features beyond the capabilities of NSText. You can also do more powerful and more creative text manipulation (such as displaying text in a circle) using NSTextStorage, NSLayoutManager, NSTextContainer, and related classes. You are more likely to use the NSTextView class than the NSText class. It is also important to remember that NSTextView conforms to a large number of protocols, the methods of which are available to instances of the NSTextView class.")]

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
//        let view = NSView()
//        view.wantsLayer = true
//        view.layer?.backgroundColor = NSColor.red.cgColor
//
//        let viewL = NSView()
//        viewL.wantsLayer = true
//        viewL.layer?.backgroundColor = NSColor.blue.cgColor
//
//        let viewT = NSView()
//        viewT.wantsLayer = true
//        viewT.layer?.backgroundColor = NSColor.yellow.cgColor
//
//        let superView = self.window.contentView!
//        superView.addSubview(view)
//        superView.addSubview(viewL)
//        superView.addSubview(viewT)
//
//        viewL.visualLayout(.H(|-20-viewL-20-view),
//                           .V(|-viewL-|))
//        viewL.width == 50
//        view.visualLayout(.H(view-50-|),
//                          .V(viewT-20-view-40-|))
//        view.height == 50
//        viewT.visualLayout(.H(|-10-viewT-(*0.9 + 20)-|),
//                           .V(|-viewT))

        let scrollView = NSScrollView()
        let superView = self.window.contentView!
        superView.addSubview(scrollView)
        scrollView.visualLayout(.H(|-10-scrollView-10-|),
                                .V(|-10-scrollView-10-|))
        scrollView.documentView = tableView

        tableView.headerView = nil
        let column = NSTableColumn.init(identifier: NSUserInterfaceItemIdentifier(rawValue: "1"))
        tableView.addTableColumn(column)
        column.sizeToFit()
        self.window.layoutIfNeeded()
        tableView.delegate = self
        tableView.dataSource = self
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

extension AppDelegate: NSTableViewDelegate, NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return demoArray.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var viewCell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "identifier"), owner: self)
        if nil == viewCell {
            viewCell = AutolayoutCellView()
            viewCell?.identifier = NSUserInterfaceItemIdentifier(rawValue: "identifier")
        }
        if let view = viewCell as? AutolayoutCellView {
            view.title.stringValue = demoArray[row].0
            view.text.stringValue = demoArray[row].1
            view.frame.size.width = tableView.frame.size.width
            view.layoutSubtreeIfNeeded()
        }
        return viewCell
    }

    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return AutolayoutCellView.dynamicHeight(tableView, demoArray[row].0, demoArray[row].1)
    }
}
