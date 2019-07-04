//
//  AppDelegate.swift
//  XLayoutDemo
//
//  Created by Jovi on 7/3/19.
//  Copyright © 2019 Jovi. All rights reserved.
//

import Cocoa
import XLayout

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application

        let view = NSView()
        view.wantsLayer = true
        view.layer?.backgroundColor = .black

        self.window.contentView?.addSubview(view)
        view.xlp.leading(20).bottom(-10).top(20)
        view.xlp.leading(0).bottom(-50).top(40).trailing(-10)
        view.xlp.remake.leading(0).bottom(-50).top(40).trailing(-10)

        let view2 = NSView()
        view2.wantsLayer = true
        view2.layer?.backgroundColor = NSColor.red.cgColor

        self.window.contentView?.addSubview(view2)
        view2.xlp.leading(==(view.leading * 1.2 + 20) ~ 999).bottom(==(view.bottom * 0.9 - 22)).top(30).trailing(-40)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
