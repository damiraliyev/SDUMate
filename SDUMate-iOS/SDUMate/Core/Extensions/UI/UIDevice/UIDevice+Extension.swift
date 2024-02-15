//
//  UIDevice+Extension.swift
//  BePRO
//
//  Created by Yessenali Zhanaidar on 02.10.2023.
//
import UIKit

public extension UIDevice {
    
    static var identifier: String {
        guard let id = UIDevice.current.identifierForVendor?.uuidString else { return "" }
        return id
    }

    static let modelName: String = {
        let code = getVersionCode()
        let model = getVersion(code: code)
        return model == .unknown ? code : model.rawValue
    }()

    enum Model: String, CaseIterable {
        /*** iPhone ***/
        case iPhone4 = "iPhone 4"
        case iPhone4S = "iPhone 4s"
        case iPhone5 = "iPhone 5"
        case iPhone5C = "iPhone 5c"
        case iPhone5S = "iPhone 5s"
        case iPhone6 = "iPhone 6"
        case iPhone6Plus = "iPhone 6 Plus"
        case iPhone6S = "iPhone 6s"
        case iPhone6SPlus = "iPhone 6s Plus"
        case iPhoneSE = "iPhone SE"
        case iPhone7 = "iPhone 7"
        case iPhone7Plus = "iPhone 7 Plus"
        case iPhone8 = "iPhone 8"
        case iPhone8Plus = "iPhone 8 Plus"
        case iPhoneX = "iPhone X"
        case iPhoneXS = "iPhone XS"
        case iPhoneXS_Max = "iPhone XS Max"
        case iPhoneXR = "iPhone XR"
        case iPhone11 = "iPhone 11"
        case iPhone11Pro = "iPhone 11 Pro"
        case iPhone11Pro_Max = "iPhone 11 Pro Max"
        case iPhoneSE2  = "iPhone SE 2"
        case iPhone12Mini = "iPhone 12 mini"
        case iPhone12 = "iPhone 12"
        case iPhone12Pro = "iPhone 12 Pro"
        case iPhone12Pro_Max = "iPhone 12 Pro Max"
        case iPhone13Mini = "iPhone 13 Mini"
        case iPhone13 = "iPhone 13"
        case iPhone13Pro = "iPhone 13 Pro"
        case iPhone13Pro_Max = "iPhone 13 Pro Max"
        case iPhoneSE3 = "iPhone SE 3"
        case iPhone14 = "iPhone 14"
        case iPhone14Plus = "iPhone 14 Plus"
        case iPhone14Pro = "iPhone 14 Pro"
        case iPhone14Pro_Max = "iPhone 14 Pro Max"

        /*** iPad ***/
        case iPad1 = "iPad 1"
        case iPad2 = "iPad 2"
        case iPad3 = "iPad 3"
        case iPad4 = "iPad 4"
        case iPad5 = "iPad 5"
        case iPad6 = "iPad 6"
        case iPad7 = "iPad 7"
        case iPad8 = "iPad 8"
        case iPad9 = "iPad 9"
        case iPadAir = "iPad Air"
        case iPadAir2 = "iPad Air 2"
        case iPadAir3 = "iPad Air 3"
        case iPadAir4 = "iPad Air 4"
        case iPadMini = "iPad mini"
        case iPadMini2 = "iPad mini 2"
        case iPadMini3 = "iPad mini 3"
        case iPadMini4 = "iPad mini 4"
        case iPadMini5 = "iPad mini 5"
        case iPadMini6 = "iPad mini 6"

        /*** iPadPro ***/
        case iPadPro9_7Inch = "iPad Pro (9.7-inch)"
        case iPadPro10_5Inch = "iPad Pro (10.5-inch)"
        case iPadPro11_0Inch = "iPad Pro (11-inch) (1st generation)"
        case iPadPro11_0Inch2 = "iPad Pro (11-inch) (2nd generation)"
        case iPadPro11_0Inch3 = "iPad Pro (11-inch) (3rd generation)"
        case iPadPro11_0Inch4 = "iPad Pro (11-inch) (4th generation)"
        case iPadPro11_0Inch5 = "iPad Pro (11-inch) (5th generation)"

        case iPadPro12_9Inch = "iPad Pro (12.9-inch) (1st generation)"
        case iPadPro12_9Inch2 = "iPad Pro (12.9-inch) (2nd generation)"
        case iPadPro12_9Inch3 = "iPad Pro (12.9-inch) (3rd generation)"
        case iPadPro12_9Inch4 = "iPad Pro (12.9-inch) (4th generation)"
        case iPadPro12_9Inch5 = "iPad Pro (12.9-inch) (5th generation)"

        /*** iPod ***/
        case iPodTouch1Gen = "iPod touch 1"
        case iPodTouch2Gen = "iPod touch 2"
        case iPodTouch3Gen = "iPod touch 3"
        case iPodTouch4Gen = "iPod touch 4"
        case iPodTouch5Gen = "iPod touch 5"
        case iPodTouch6Gen = "iPod touch 6"
        case iPodTouch7Gen = "iPod touch 7"

        /*** simulator ***/
        case simulator

        /*** unknown ***/
        case unknown
    }

    static func getVersionCode() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let versionCode = String(validatingUTF8: NSString(bytes: &systemInfo.machine, length: Int(_SYS_NAMELEN), encoding: String.Encoding.ascii.rawValue)!.utf8String!)!
        return versionCode
    }

    // swiftlint:disable cyclomatic_complexity
    static func getVersion(code: String) -> Model {
        switch code {
        /*** iPhone ***/
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":    return .iPhone4
        case "iPhone4,1", "iPhone4,2", "iPhone4,3":    return .iPhone4S
        case "iPhone5,1", "iPhone5,2":                 return .iPhone5
        case "iPhone5,3", "iPhone5,4":                 return .iPhone5C
        case "iPhone6,1", "iPhone6,2":                 return .iPhone5S
        case "iPhone7,2":                              return .iPhone6
        case "iPhone7,1":                              return .iPhone6Plus
        case "iPhone8,1":                              return .iPhone6S
        case "iPhone8,2":                              return .iPhone6SPlus
        case "iPhone8,3", "iPhone8,4":                 return .iPhoneSE
        case "iPhone9,1", "iPhone9,3":                 return .iPhone7
        case "iPhone9,2", "iPhone9,4":                 return .iPhone7Plus
        case "iPhone10,1", "iPhone10,4":               return .iPhone8
        case "iPhone10,2", "iPhone10,5":               return .iPhone8Plus
        case "iPhone10,3", "iPhone10,6":               return .iPhoneX
        case "iPhone11,2":                             return .iPhoneXS
        case "iPhone11,4", "iPhone11,6":               return .iPhoneXS_Max
        case "iPhone11,8":                             return .iPhoneXR
        case "iPhone12,1":                             return .iPhone11
        case "iPhone12,3":                             return .iPhone11Pro
        case "iPhone12,5":                             return .iPhone11Pro_Max
        case "iPhone12,8":                             return .iPhoneSE2
        case "iPhone13,1":                             return .iPhone12Mini
        case "iPhone13,2":                             return .iPhone12
        case "iPhone13,3":                             return .iPhone12Pro
        case "iPhone13,4":                             return .iPhone12Pro_Max
        case "iPhone14,4":                             return .iPhone13Mini
        case "iPhone14,5":                             return .iPhone13
        case "iPhone14,2":                             return .iPhone13Pro
        case "iPhone14,3":                             return .iPhone13Pro_Max
        case "iPhone14,6":                             return .iPhoneSE3
        case "iPhone14,7":                             return .iPhone14
        case "iPhone14,8":                             return .iPhone14Plus
        case "iPhone15,2":                             return .iPhone14Pro
        case "iPhone15,3":                             return .iPhone14Pro_Max

        /*** iPad ***/
        case "iPad1,1", "iPad1,2":                       return .iPad1
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return .iPad2
        case "iPad3,1", "iPad3,2", "iPad3,3":            return .iPad3
        case "iPad3,4", "iPad3,5", "iPad3,6":            return .iPad4
        case "iPad6,11", "iPad6,12":                     return .iPad5
        case "iPad7,5", "iPad7,6":                       return .iPad6
        case "iPad7,11", "iPad7,12":                     return .iPad7
        case "iPad11,6", "iPad11,7":                     return .iPad8
        case "iPad12,1", "iPad12,2":                     return .iPad9
        case "iPad4,1", "iPad4,2", "iPad4,3":            return .iPadAir
        case "iPad5,3", "iPad5,4":                       return .iPadAir2
        case "iPad11,3", "iPad11,4":                     return .iPadAir3
        case "iPad13,1", "iPad13,2":                     return .iPadAir4
        case "iPad2,5", "iPad2,6", "iPad2,7":            return .iPadMini
        case "iPad4,4", "iPad4,5", "iPad4,6":            return .iPadMini2
        case "iPad4,7", "iPad4,8", "iPad4,9":            return .iPadMini3
        case "iPad5,1", "iPad5,2":                       return .iPadMini4
        case "iPad11,1", "iPad11,2":                     return .iPadMini5
        case "iPad14,1", "iPad14,2":                     return .iPadMini6

        /*** iPadPro ***/
        case "iPad6,3", "iPad6,4":                              return .iPadPro9_7Inch
        case "iPad7,3", "iPad7,4":                              return .iPadPro10_5Inch
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":        return .iPadPro11_0Inch
        case "iPad8,9", "iPad8,10":                             return .iPadPro11_0Inch2
        case "iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7":    return .iPadPro11_0Inch3
        case "iPad6,7", "iPad6,8":                              return .iPadPro12_9Inch
        case "iPad7,1", "iPad7,2":                              return .iPadPro12_9Inch2
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":        return .iPadPro12_9Inch3
        case "iPad8,11", "iPad8,12":                            return .iPadPro12_9Inch4
        case "iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11":  return .iPadPro12_9Inch5

        /*** iPod ***/
        case "iPod1,1":                                  return .iPodTouch1Gen
        case "iPod2,1":                                  return .iPodTouch2Gen
        case "iPod3,1":                                  return .iPodTouch3Gen
        case "iPod4,1":                                  return .iPodTouch4Gen
        case "iPod5,1":                                  return .iPodTouch5Gen
        case "iPod7,1":                                  return .iPodTouch6Gen
        case "iPod9,1":                                  return .iPodTouch7Gen

        /*** Simulator ***/
        case "i386", "x86_64":                           return .simulator

        default:                                         return .unknown
        }
    }
}
