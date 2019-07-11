//
//  VisualLayoutAPITests.swift
//  XLayoutTests
//
//  Created by Jovi on 7/11/19.
//  Copyright © 2019 Jovi. All rights reserved.
//

import XCTest
import XLayout

class VisualLayoutAPITests: XCTestCase {

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
        contentView.xLayout.leading(20).trailing(-20).bottom(-20).top(20)
        contentView.layoutSubtreeIfNeeded()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testSimpleVisualLayoutMethods() {
        let view = NSView()
        let superView = self.window.contentView!
        superView.addSubview(view)

        // make some constraints
        view.visualLayout(XLayoutH(|-20-view-20-|),
                          XLayoutV(|-20-view-20-|))
        view.layoutSubtreeIfNeeded()
        XCTAssertEqual(view.frame.minX, superView.frame.minX + 20)
        XCTAssertEqual(view.frame.maxX, superView.frame.maxX - 20)
        XCTAssertEqual(view.frame.minY, superView.frame.minY + 20)
        XCTAssertEqual(view.frame.maxY, superView.frame.maxY - 20)

        // update part(.leading, .top) of constraints
        view.leading == 50
        view.top == 50
        view.visualLayout(XLayoutH(|-50-view),
                          XLayoutV(|-50-view))
        view.layoutSubtreeIfNeeded()
        XCTAssertEqual(view.frame.minX, superView.frame.minX + 50)
        XCTAssertEqual(view.frame.maxX, superView.frame.maxX - 20)
        XCTAssertEqual(view.frame.minY, superView.frame.minY + 20)
        XCTAssertEqual(view.frame.maxY, superView.frame.maxY - 50)

        // update all constraints
        view.visualLayout(XLayoutH(|-30-view-10-|),
                          XLayoutV(|-30-view-10-|))
        view.layoutSubtreeIfNeeded()
        XCTAssertEqual(view.frame.minX, superView.frame.minX + 30)
        XCTAssertEqual(view.frame.maxX, superView.frame.maxX - 10)
        XCTAssertEqual(view.frame.minY, superView.frame.minY + 10)
        XCTAssertEqual(view.frame.maxY, superView.frame.maxY - 30)

        // remake all constraints
        view.remakeLayout()
        view.width == 100
        view.height == 100
        view.visualLayout(XLayoutH(|-20-view),
                          XLayoutV(|-20-view))
        view.layoutSubtreeIfNeeded()
        XCTAssertEqual(view.frame.width, 100)
        XCTAssertEqual(view.frame.height, 100)
        XCTAssertEqual(view.frame.minX, superView.frame.minX + 20)
        XCTAssertEqual(view.frame.maxY, superView.frame.maxY - 20)
    }

    func testVisualLayoutMethodsByPriority() {
        let view = NSView()
        let superView = self.window.contentView!
        superView.addSubview(view)

        view.width == 180
        view.visualLayout(XLayoutH(|-(30 ~ 250)-view-50-|),
                          XLayoutV(|-20-view-20-|))
        view.layoutSubtreeIfNeeded()
        XCTAssertLessThan(view.frame.minX, superView.frame.minX + 20)
        XCTAssertEqual(view.frame.maxX, superView.frame.maxX - 50)
        XCTAssertEqual(view.frame.minY, superView.frame.minY + 20)
        XCTAssertEqual(view.frame.maxY, superView.frame.maxY - 20)
        XCTAssertEqual(view.frame.width, 180)
    }

    func testVisualLayoutMethodsByMultiplier() {
        let view = NSView()
        let superView = self.window.contentView!
        superView.addSubview(view)

        view.visualLayout(XLayoutH(|-(*0.7)-view-(*0.6)-|),
                          XLayoutV(|-(*0.8)-view-(*0.9)-|))
        view.layoutSubtreeIfNeeded()
        XCTAssertEqual(view.frame.minX, superView.frame.minX * 0.7)
        XCTAssertEqual(view.frame.maxX, superView.frame.maxX * 0.6)
        XCTAssertEqual(view.frame.minY, superView.frame.minY + superView.frame.maxY * 0.1)
        XCTAssertEqual(view.frame.maxY, superView.frame.maxY + superView.frame.minY * 0.2)
    }

    func testVisualLayoutMethodsByRelation() {
        let view = NSView()
        let superView = self.window.contentView!
        superView.addSubview(view)

        view.visualLayout(XLayoutH(|-(*0.7)-view-(<=(*0.6))-|),
                          XLayoutV(|-(*0.8)-view-(*0.9)-|))
        view.width >= 200
        view.layoutSubtreeIfNeeded()
        XCTAssertEqual(view.frame.minX, superView.frame.minX * 0.7)
        XCTAssertGreaterThan(view.frame.maxX, superView.frame.maxX * 0.6)
        XCTAssertEqual(view.frame.minY, superView.frame.minY + superView.frame.maxY * 0.1)
        XCTAssertEqual(view.frame.maxY, superView.frame.maxY + superView.frame.minY * 0.2)
        XCTAssertEqual(view.frame.width, 200)
    }

    func testComplexVisualLayoutMethods() {
        let view = NSView()
        let viewL = NSView()
        let viewT = NSView()
        let superView = self.window.contentView!
        superView.addSubview(view)
        superView.addSubview(viewL)
        superView.addSubview(viewT)

        viewL.visualLayout(XLayoutH(|-20-viewL-20-view),
                           XLayoutV(|-viewL-|))
        viewL.width == 50
        view.visualLayout(XLayoutH(view-|),
                           XLayoutV(viewT-view-40-|))
        view.height == 50
        viewT.visualLayout(XLayoutH(|-10-viewT-(*0.9 + 20)-|),
                           XLayoutV(|-viewT-view))

        superView.layoutSubtreeIfNeeded()
        XCTAssertEqual(viewL.frame.minX, superView.frame.minX + 20)
        XCTAssertEqual(viewL.frame.maxX, 70)
        XCTAssertEqual(viewL.frame.minY, superView.frame.minY)
        XCTAssertEqual(viewL.frame.maxY, superView.frame.maxY)
        XCTAssertEqual(viewL.frame.width, 50)
        XCTAssertEqual(view.frame.maxX, superView.frame.maxX)
        XCTAssertEqual(view.frame.minX, viewL.frame.maxX + 20)
        XCTAssertEqual(view.frame.maxY, viewT.frame.minY)
        XCTAssertEqual(view.frame.minY, superView.frame.minY + 40)
        XCTAssertEqual(view.frame.height, 50)
        XCTAssertEqual(viewT.frame.minX, 10)
        XCTAssertEqual(viewT.frame.maxX + 20, superView.frame.maxX * 0.9)
        XCTAssertEqual(viewT.frame.minY, view.frame.maxY)
        XCTAssertEqual(viewT.frame.maxY, superView.frame.maxY)
    }

}
