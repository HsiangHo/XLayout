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
    var contentView: XLayoutView!

    override func setUp() {
        super.setUp()
        window = NSWindow.init(contentRect: NSRect(x: 0, y: 0, width: 240, height: 240),
                               styleMask: [.titled, .closable],
                               backing: .buffered,
                               defer: false)
        contentView = XLayoutView()
        self.window.contentView?.addSubview(contentView)
        contentView.xlp.leading(20).trailing(-20).bottom(-20).top(20)
        contentView.layoutSubtreeIfNeeded()
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

    func testChainingMethodsByPriority() {
        let view = NSView()
        let superView = self.window.contentView!
        superView.addSubview(view)

        view.xlp.leading(20 ~ 250).trailing(-50).bottom(-20).top(20).width(140)
        view.layoutSubtreeIfNeeded()
        XCTAssertLessThan(view.frame.minX, superView.frame.minX + 20)
        XCTAssertEqual(view.frame.maxX, superView.frame.maxX - 50)
        XCTAssertEqual(view.frame.minY, superView.frame.minY + 20)
        XCTAssertEqual(view.frame.maxY, superView.frame.maxY - 20)
        XCTAssertEqual(view.frame.width, 140)
    }

    func testChainingMethodsByViewProperty() {
        let view = NSView()
        let superView = self.window.contentView!
        superView.addSubview(view)

        view.xlp.leading(contentView.leading)
            .trailing(contentView.trailing)
            .bottom(contentView.bottom)
            .top(contentView.top)
        view.layoutSubtreeIfNeeded()
        XCTAssertEqual(view.frame.minX, contentView.frame.minX)
        XCTAssertEqual(view.frame.maxX, contentView.frame.maxX)
        XCTAssertEqual(view.frame.minY, contentView.frame.minY)
        XCTAssertEqual(view.frame.maxY, contentView.frame.maxY)
    }

    func testChainingMethodsByMultiplier() {
        let view = NSView()
        let superView = self.window.contentView!
        superView.addSubview(view)

        view.xlp.leading(contentView.leading*0.7)
            .trailing(*0.6)
            .bottom(contentView.bottom*0.9)
            .top(contentView.top*0.8)
        view.layoutSubtreeIfNeeded()
        XCTAssertEqual(view.frame.minX, contentView.frame.minX * 0.7)
        XCTAssertEqual(view.frame.maxX, superView.frame.maxX * 0.6)
        XCTAssertEqual(view.frame.minY, contentView.frame.minY + contentView.frame.maxY * 0.1)
        XCTAssertEqual(view.frame.maxY, contentView.frame.maxY + contentView.frame.minY * 0.2)
    }

    func testChainingMethodsByRelation() {
        let view = NSView()
        let superView = self.window.contentView!
        superView.addSubview(view)

        view.xlp.leading(==(contentView.leading*0.7))
            .trailing(<=(*0.6))
            .bottom(contentView.bottom*0.9)
            .top(contentView.top*0.8)
            .width(>=200)
        view.layoutSubtreeIfNeeded()
        XCTAssertEqual(view.frame.minX, contentView.frame.minX * 0.7)
        XCTAssertGreaterThan(view.frame.maxX, superView.frame.maxX * 0.6)
        XCTAssertEqual(view.frame.minY, contentView.frame.minY + contentView.frame.maxY * 0.1)
        XCTAssertEqual(view.frame.maxY, contentView.frame.maxY + contentView.frame.minY * 0.2)
        XCTAssertEqual(view.frame.width, 200)
    }

    func testComplexChainingMethods() {
        let view = NSView()
        let superView = self.window.contentView!
        superView.addSubview(view)

        view.xlp.leading(==(contentView.leading*0.7 + 20) ~ 210)
            .trailing(<=(*0.6-50))
            .bottom(>=(contentView.bottom - 20))
            .top(contentView.top*0.8)
            .width(200)
        view.layoutSubtreeIfNeeded()
        XCTAssertLessThan(view.frame.minX, contentView.frame.minX * 0.7 + 20)
        XCTAssertEqual(view.frame.maxX, superView.frame.maxX * 0.6 - 50)
        XCTAssertGreaterThan(view.frame.minY, contentView.frame.minY - 20)
        XCTAssertEqual(view.frame.maxY, contentView.frame.maxY + contentView.frame.minY * 0.2)
        XCTAssertEqual(view.frame.width, 200)
    }
}
