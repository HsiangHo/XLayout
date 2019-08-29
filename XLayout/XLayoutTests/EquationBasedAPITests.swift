//
//  EquationBasedAPITests.swift
//  XLayoutTests
//
//  Created by Jovi on 7/6/19.
//  Copyright © 2019 Jovi. All rights reserved.
//

import XCTest
import XLayout

class EquationBasedAPITests: XCTestCase {
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
        contentView.leading == 20
        contentView.trailing == -20
        contentView.bottom == -20
        contentView.top == 20
        contentView.layoutSubtreeIfNeeded()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testSimpleEquationBasedMethods() {
        let view = NSView()
        let superView = self.window.contentView!
        superView.addSubview(view)

        // make some constraints
        view.leading == 20
        view.trailing == -20
        view.bottom == -20
        view.top == 20
        view.layoutSubtreeIfNeeded()
        XCTAssertEqual(view.frame.minX, superView.frame.minX + 20)
        XCTAssertEqual(view.frame.maxX, superView.frame.maxX - 20)
        XCTAssertEqual(view.frame.minY, superView.frame.minY + 20)
        XCTAssertEqual(view.frame.maxY, superView.frame.maxY - 20)

        // update part(.leading, .top) of constraints
        view.leading == 50
        view.top == 50
        view.layoutSubtreeIfNeeded()
        XCTAssertEqual(view.frame.minX, superView.frame.minX + 50)
        XCTAssertEqual(view.frame.maxX, superView.frame.maxX - 20)
        XCTAssertEqual(view.frame.minY, superView.frame.minY + 20)
        XCTAssertEqual(view.frame.maxY, superView.frame.maxY - 50)

        // update all constraints
        view.leading == 30
        view.top == 30
        view.trailing == -10
        view.bottom == -10
        view.layoutSubtreeIfNeeded()
        XCTAssertEqual(view.frame.minX, superView.frame.minX + 30)
        XCTAssertEqual(view.frame.maxX, superView.frame.maxX - 10)
        XCTAssertEqual(view.frame.minY, superView.frame.minY + 10)
        XCTAssertEqual(view.frame.maxY, superView.frame.maxY - 30)

        // remake all constraints
        view.remakeLayout()
        view.width == 100
        view.height == 100
        view.leading == 20
        view.top == 20
        view.layoutSubtreeIfNeeded()
        XCTAssertEqual(view.frame.width, 100)
        XCTAssertEqual(view.frame.height, 100)
        XCTAssertEqual(view.frame.minX, superView.frame.minX + 20)
        XCTAssertEqual(view.frame.maxY, superView.frame.maxY - 20)
    }

    func testEquationBasedMethodsByPriority() {
        let view = NSView()
        let superView = self.window.contentView!
        superView.addSubview(view)

        view.leading == 20 ~ 250
        view.trailing == -50
        view.bottom == -20
        view.top == 20
        view.width == 180
        view.layoutSubtreeIfNeeded()
        XCTAssertLessThan(view.frame.minX, superView.frame.minX + 20)
        XCTAssertEqual(view.frame.maxX, superView.frame.maxX - 50)
        XCTAssertEqual(view.frame.minY, superView.frame.minY + 20)
        XCTAssertEqual(view.frame.maxY, superView.frame.maxY - 20)
        XCTAssertEqual(view.frame.width, 180)
    }

    func testEquationBasedMethodsByViewProperty() {
        let view = NSView()
        let superView = self.window.contentView!
        superView.addSubview(view)

        view.leading == contentView.leading
        view.trailing == contentView.trailing
        view.bottom == contentView.bottom
        view.top == contentView.top

        view.layoutSubtreeIfNeeded()
        XCTAssertEqual(view.frame.minX, contentView.frame.minX)
        XCTAssertEqual(view.frame.maxX, contentView.frame.maxX)
        XCTAssertEqual(view.frame.minY, contentView.frame.minY)
        XCTAssertEqual(view.frame.maxY, contentView.frame.maxY)
    }

    func testEquationBasedMethodsByMultiplier() {
        let view = NSView()
        let superView = self.window.contentView!
        superView.addSubview(view)

        view.leading == contentView.leading*0.7
        view.trailing == *0.6
        view.bottom == contentView.bottom*0.9
        view.top == contentView.top*0.8

        view.layoutSubtreeIfNeeded()
        XCTAssertEqual(view.frame.minX, contentView.frame.minX * 0.7)
        XCTAssertEqual(view.frame.maxX, superView.frame.maxX * 0.6)
        XCTAssertEqual(view.frame.minY, contentView.frame.minY + contentView.frame.maxY * 0.1)
        XCTAssertEqual(view.frame.maxY, contentView.frame.maxY + contentView.frame.minY * 0.2)
    }

    func testEquationBasedMethodsByRelation() {
        let view = NSView()
        let superView = self.window.contentView!
        superView.addSubview(view)

        view.leading == contentView.leading*0.7
        view.trailing <= *0.6
        view.bottom == contentView.bottom*0.9
        view.top == contentView.top*0.8
        view.width >= 200

        view.layoutSubtreeIfNeeded()
        XCTAssertEqual(view.frame.minX, contentView.frame.minX * 0.7)
        XCTAssertGreaterThan(view.frame.maxX, superView.frame.maxX * 0.6)
        XCTAssertEqual(view.frame.minY, contentView.frame.minY + contentView.frame.maxY * 0.1)
        XCTAssertEqual(view.frame.maxY, contentView.frame.maxY + contentView.frame.minY * 0.2)
        XCTAssertEqual(view.frame.width, 200)
    }

    func testComplexEquationBasedMethods() {
        let view = NSView()
        let superView = self.window.contentView!
        superView.addSubview(view)

        view.leading == (contentView.leading*0.7 + 20) ~ 210
        view.trailing <= *0.6-50
        view.bottom >= contentView.bottom - 20
        view.top == contentView.top*0.8
        view.width == 200

        view.layoutSubtreeIfNeeded()
        XCTAssertLessThan(view.frame.minX, contentView.frame.minX * 0.7 + 20)
        XCTAssertEqual(view.frame.maxX, superView.frame.maxX * 0.6 - 50)
        XCTAssertGreaterThan(view.frame.minY, contentView.frame.minY - 20)
        XCTAssertEqual(view.frame.maxY, contentView.frame.maxY + contentView.frame.minY * 0.2)
        XCTAssertEqual(view.frame.width, 200)
    }

}
