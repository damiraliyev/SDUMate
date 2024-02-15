//
//  Device.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 06.07.2023.
//

import UIKit
import SystemConfiguration

struct Device {
    public static var hasHomeIndicator: Bool {
        return UIView.safeBottomAreaHeight > 0
    }
    
    public static var isSmall: Bool {
        return UIView.screenWidth < 376
    }
    
    static var isConnectedToNetwork: Bool {
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
    
    static var identifier: String {
        guard let id = UIDevice.current.identifierForVendor?.uuidString else { return "" }
        return id
    }
}
