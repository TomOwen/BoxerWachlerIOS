//
//  checkInternet.swift
//  BoxerWachler
//
//  Created by Tom Owen on 6/30/16.
//  Copyright © 2016 Boxer Wachler Vision Institute. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration

open class Reachability {
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    class func isInternetUp() {
        let isLive = Reachability.isConnectedToNetwork()
        if (Global.didCheck) { return }
        Global.didCheck = true
        if (!isLive) {
            let alert = UIAlertView(title: "No Internet Connection", message: "Some videos may not be available without an internet connection. To view the videos turn on your internet connection and then click on the Refresh button on top right of screen.", delegate: self, cancelButtonTitle: "Ok!")
            alert.show()
        }
    }
    class Global {
        static var didCheck: Bool = false
    }
}
