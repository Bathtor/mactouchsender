//
//  AppDelegate.swift
//  MouseTracker
//
//  Created by Lars Kroll on 2019-08-13.
//  Copyright © 2019 Lars Kroll. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    var udpSender: NetSender?;
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        print("setting up!");
        var frame = self.window?.frame
        frame?.size = NSSize(width: 505, height:323)
        self.window?.setFrame(frame!, display: true)
        udpSender = NetSender();
        udpSender?.sendPacket(str: "Test!");
        NSEvent.addLocalMonitorForEvents(
            matching: NSEvent.EventTypeMask.pressure,
            handler: { (event: NSEvent) -> NSEvent? in
                let loc = event.locationInWindow;
                let str = "\(event.timestamp),\(loc.x),\(loc.y),\(event.pressure)\n";
                print(str);
                self.udpSender?.sendPacket(str: str);
                return nil;
        });
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        print("tearing down");
        udpSender = nil;
    }


}
