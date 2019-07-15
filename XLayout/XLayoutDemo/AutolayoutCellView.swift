//
//  AutolayoutCellView.swift
//  XLayoutDemo
//
//  Created by Jovi on 7/14/19.
//  Copyright © 2019 Jovi. All rights reserved.
//

import Cocoa
import XLayout

class AutolayoutCellView: NSView {
    public let title = NSTextField()
    public let img = NSImageView()
    public let text = NSTextField()
    static var wnd = NSWindow.init(contentRect: NSRect(x: 0, y: 0, width: 10, height: 10),
                                   styleMask: .borderless,
                                   backing: .buffered,
                                   defer: false)

    init() {
        title.isBordered = false
        title.stringValue = ""
        title.backgroundColor = NSColor.clear
        title.isSelectable = false
        title.isEditable = false
        title.lineBreakMode = .byWordWrapping
        img.image = NSImage.init(named: "NSComputer")
        img.imageScaling = .scaleAxesIndependently
        text.backgroundColor = NSColor.clear
        text.stringValue = ""
        text.isBordered = false
        text.isSelectable = false
        text.isEditable = false
        text.lineBreakMode = .byWordWrapping
        super.init(frame: NSRect(x: 0, y: 0, width: 0, height: 0))
        self.addSubview(title)
        self.addSubview(img)
        self.addSubview(text)
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()
        title.visualLayout(.H(|-8-title-5-|), .V(|-10-title))
        img.visualLayout(.V(title-img-(>=0 ~ 500)-|))
        img.leading == title.leading
        img.height == 64
        img.width == 64
        text.visualLayout(.H(img-text-|), .V(title-text-(8 ~ 600)-|))
    }

    static func dynamicHeight(_ tableView: NSTableView, _ title: String, _ text: String) -> CGFloat {
        let wnd = AutolayoutCellView.wnd
        let view = AutolayoutCellView()
        view.title.stringValue = title
        view.text.stringValue = text
        wnd.setFrame(NSRect(x: 0, y: 0, width: tableView.frame.width, height: 0), display: false)
        wnd.contentView = view
        wnd.layoutIfNeeded()
        let height = view.frame.height
        wnd.contentView = nil
        return height
    }
}
