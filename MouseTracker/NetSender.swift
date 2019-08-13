//
//  NetSender.swift
//  MouseTracker
//
//  Created by Lars Kroll on 2019-08-13.
//  Copyright © 2019 Lars Kroll. All rights reserved.
//

import Cocoa
import CocoaAsyncSocket

class NetSender: NSObject, GCDAsyncUdpSocketDelegate {
    
    var _socket: GCDAsyncUdpSocket?
    var socket: GCDAsyncUdpSocket? {
        get {
            if _socket == nil {
                let port = UInt16(45678);
                let sock = GCDAsyncUdpSocket(delegate: self, delegateQueue: .main);
                do {
                    try sock.bind(toPort: port);
                    //try sock.beginReceiving();
                } catch let err as NSError {
                    print(">>> Error while initializing socket: \(err.localizedDescription)");
                    sock.close();
                    return nil;
                }
                _socket = sock;
            }
            return _socket;
        }
        set {
            _socket?.close();
            _socket = newValue;
        }
    }
    
    func sendPacket(str: String) {
        let host = "127.0.0.1";
        let port = UInt16(45679);
        
        guard socket != nil else {
            print("But but but...no socket!");
            return;
        }
        socket?.send(str.data(using: String.Encoding.utf8)!, toHost: host, port: port, withTimeout: -1, tag: 0);
        print("Data sent: \(str)");
    }
    
    /**
     * Called when the datagram with the given tag has been sent.
     **/
    func udpSocket(_ sock: GCDAsyncUdpSocket, didSendDataWithTag tag: Int) {
        print("Did send data!");
    }
    
    /**
     * Called if an error occurs while trying to send a datagram.
     * This could be due to a timeout, or something more serious such as the data being too large to fit in a sigle packet.
     **/
    func udpSocket(_ sock: GCDAsyncUdpSocket, didNotSendDataWithTag tag: Int, dueToError error: Error?) {
        print("Could not send data, because \(error?.localizedDescription ?? "who knows-.-")");
    }

}
