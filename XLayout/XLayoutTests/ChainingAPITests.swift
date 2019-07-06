//
//  ChainingAPITests.swift
//  XLayoutTests
//
//  Created by Jovi on 7/6/19.
//  Copyright © 2019 Jovi. All rights reserved.
//

import XCTest
import XLayout

class ChainingAPITests: XCTestCase {
    var window: NSWindow!

    override func setUp() {
        super.setUp()
        window = NSWindow.init(contentRect: NSRect(x: 0, y: 0, width: 200, height: 200),
                               styleMask: [.titled, .closable],
                               backing: .buffered,
                               defer: false)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testSimpleChainingMethods() {
        let view = NSView()
        let superView = self.window.contentView!
        superView.addSubview(view)
        view.xlp.leading(20).trailing(-20).bottom(-20).top(20)
    }
}
