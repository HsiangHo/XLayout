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
        view.layer?.backgroundColor = NSColor.red.cgColor

        let viewL = NSView()
        viewL.wantsLayer = true
        viewL.layer?.backgroundColor = NSColor.blue.cgColor

        let viewT = NSView()
        viewT.wantsLayer = true
        viewT.layer?.backgroundColor = NSColor.yellow.cgColor

        let superView = self.window.contentView!
        superView.addSubview(view)
        superView.addSubview(viewL)
        superView.addSubview(viewT)

        viewL.visualLayout(.H(|-20-viewL-20-view),
                           .V(|-viewL-|))
        viewL.width == 50
        view.visualLayout(.H(view-50-|),
                          .V(viewT-20-view-40-|))
        view.height == 50
        viewT.visualLayout(.H(|-10-viewT-(*0.9 + 20)-|),
                           .V(|-viewT))
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
