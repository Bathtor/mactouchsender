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
        udpSender = NetSender();
//        NSEvent.addGlobalMonitorForEvents(
//            matching: NSEvent.EventTypeMask.leftMouseDown,
//            handler: { (event: NSEvent) -> Void in
//            let point = NSEvent.mouseLocation;
//            print("X: \(point.x)");
//            print("Y: \(point.y)");
//        });
        udpSender?.sendPacket(str: "Test!");
        NSEvent.addLocalMonitorForEvents(
            matching: NSEvent.EventTypeMask.pressure,
            handler: { (event: NSEvent) -> NSEvent? in
                let point = NSEvent.mouseLocation;
                print("X: \(point.x)");
                print("Y: \(point.y)");
                print("Pressure: \(event.pressure)");
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
