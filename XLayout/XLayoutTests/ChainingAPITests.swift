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

        // make some constraints
        view.xlp.leading(20).trailing(-20).bottom(-20).top(20)
        view.layoutSubtreeIfNeeded()
        XCTAssertEqual(view.frame.minX, superView.frame.minX + 20)
        XCTAssertEqual(view.frame.maxX, superView.frame.maxX - 20)
        XCTAssertEqual(view.frame.minY, superView.frame.minY + 20)
        XCTAssertEqual(view.frame.maxY, superView.frame.maxY - 20)

        // update part(.leading, .top) of constraints
        view.xlp.leading.top(50)
        view.layoutSubtreeIfNeeded()
        XCTAssertEqual(view.frame.minX, superView.frame.minX + 50)
        XCTAssertEqual(view.frame.maxX, superView.frame.maxX - 20)
        XCTAssertEqual(view.frame.minY, superView.frame.minY + 20)
        XCTAssertEqual(view.frame.maxY, superView.frame.maxY - 50)

        // update all constraints
        view.xlp.leading.top(30).trailing.bottom(-10)
        view.layoutSubtreeIfNeeded()
        XCTAssertEqual(view.frame.minX, superView.frame.minX + 30)
        XCTAssertEqual(view.frame.maxX, superView.frame.maxX - 10)
        XCTAssertEqual(view.frame.minY, superView.frame.minY + 10)
        XCTAssertEqual(view.frame.maxY, superView.frame.maxY - 30)

        // remake all constraints
        view.xlp.remake.width.height(100).leading.top(20)
        view.layoutSubtreeIfNeeded()
        XCTAssertEqual(view.frame.width, 100)
        XCTAssertEqual(view.frame.height, 100)
        XCTAssertEqual(view.frame.minX, superView.frame.minX + 20)
        XCTAssertEqual(view.frame.maxY, superView.frame.maxY - 20)
    }
}
