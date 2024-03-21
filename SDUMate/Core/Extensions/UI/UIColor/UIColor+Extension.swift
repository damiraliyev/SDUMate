//
//  UIColor+Extension.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 05.07.2023.
//

import UIKit

public extension UIColor {
    
    static var background: UIColor {
        return UIColor(hex: 0x000040)
    }
    
    static var orange: UIColor {
        return UIColor(hex: 0xFF9E44)
    }
    
    static var lavender: UIColor {
        return UIColor(hex: 0xCFCBFF)
    }
    
    static var textFieldBorderPurple: UIColor {
        return UIColor(hex: 0x383467)
    }
    
    static var textFieldInner: UIColor {
        return UIColor(hex: 0x20204D)
    }
    
    static var textColor: UIColor {
        return UIColor(hex: 0x1F1F1F)
    }
    
    static var beProBlack: UIColor {
        return UIColor(hex: 0x000000)
    }
    
    static var beProWhite: UIColor {
        UIColor(hex: 0xFFFFFF)
    }
    
    static var bpSecondaryWhite: UIColor {
        UIColor(hex: 0xEDF0F2)
    }
    
    static var moduleDescription: UIColor {
        UIColor(hex: 0x93A1A9)
    }
    
    static var dark: UIColor {
        return UIColor(hex: 0x384046)
    }
    
    static var bpText: UIColor {
        return UIColor(hex: 0x29353B)
    }
    
    static var bpGray: UIColor {
        return UIColor(hex: 0x9BA1AE)
    }
    
    static var accentGrey: UIColor {
        return UIColor(hex: 0xD4D4D4)
    }
    
    static var bpLightGray: UIColor {
        return UIColor(hex: 0xF6F7F9)
    }
    
    static var employeeSearchBorder: UIColor {
        return UIColor(hex: 0xEFEFEF)
    }
    
    static var accentRed: UIColor {
        return UIColor(hex: 0xF24439)
    }
    
    static var accentOrange: UIColor {
        UIColor(hex: 0xF2994A)
    }
    
    static var accentGreen: UIColor {
        return UIColor(hex: 0x27AE60)
    }
    
    static var lightGreen: UIColor {
        return UIColor(hex: 0x7FBE18)
    }
    
    static var yellow: UIColor {
        return UIColor(hex: 0xF2C940)
    }
    
    static var lightYellow: UIColor {
        return UIColor(hex: 0xFFFA82)
    }
    
    static var secondaryYellow: UIColor {
        return UIColor(hex: 0xF9E15B)
    }
    
    static var mustard: UIColor {
        return UIColor(hex: 0xE9AB1C)
    }
    
    static var bpCyan: UIColor {
        return UIColor(hex: 0x4CA4C9)
    }
    
    static var inZoneColor: UIColor {
        return UIColor(hex: 0xE4E8F1)
    }
    
    static var outZoneColor: UIColor {
        return UIColor(hex: 0xF24439).withAlphaComponent(0.1)
    }
    
    static var skeletonColor: UIColor {
        UIColor(hex: 0xBEBEB6).withAlphaComponent(0.2)
    }
    
    static var gold: UIColor {
        UIColor(hex: 0xFFD700)
    }
    
    static var bpBorderColor: UIColor {
        UIColor(hex: 0xCBD3DA)
    }
    
    static var trelloGray: UIColor {
        UIColor(hex: 0x727F87)
    }
    
    static var trelloRecording: UIColor {
        UIColor(hex: 0x90979D)
    }
    
    static var trelloTaskExpired: UIColor {
        return UIColor(hex: 0xF24439).withAlphaComponent(0.6)
    }
    
    static var regCategoryBgColor: UIColor {
        return UIColor(hex: 0xFBFBFB)
    }
    
    static var successOkGreen: UIColor {
        return UIColor(hex: 0x4A9F8D)
    }
    
    static var loadingProgressBgGray: UIColor {
        return UIColor(hex: 0xF6F6F6)
    }
    
    static var progressTrackGray: UIColor {
        return UIColor(hex: 0xBDBDBD)
    }
    
    static var disabledGray: UIColor {
        return UIColor(hex: 0xC5CCD1)
    }
    
    static var deleteRed: UIColor {
        return UIColor(hex: 0xEF5245)
    }
    
    static var alertRed: UIColor {
        return UIColor(hex: 0xE8392E)
    }
    
    static var tariffSecondaryText: UIColor {
        return UIColor(hex: 0x515C65)
    }
    
    static var statusAbsent: UIColor {
        return UIColor(hex: 0x384046)
    }
    
    static var statusDayOff: UIColor {
        return UIColor(hex: 0xF5A81E)
    }
    
    static var statusDefaultDayLabel: UIColor {
        return UIColor(hex: 0x384046)
    }
    
    static var statusExtraDayLabel: UIColor {
        return UIColor(hex: 0x9BA0AD).withAlphaComponent(0.3)
    }
    
    static var statusLate: UIColor {
        return UIColor(hex: 0xF14439)
    }
    
    static var statusOnTime: UIColor {
        return UIColor(hex: 0x27AD5F)
    }
    
    static var statusTakeOff: UIColor {
        return UIColor(hex: 0xECEFF1)
    }
    
    static var statusVacation: UIColor {
        return UIColor(hex: 0xF6F7F8)
    }
    
    static var proPointBad: UIColor {
        return UIColor(hex: 0xF04439)
    }
    
    static var proPointBetter: UIColor {
        return UIColor(hex: 0x83AC27)
    }
    
    static var proPointExcellent: UIColor {
        return UIColor(hex: 0x27AC5F)
    }
    
    static var proPointGood: UIColor {
        return UIColor(hex: 0xFFAC31)
    }
    
    static var audioIndicatorRed: UIColor {
        return UIColor(hex: 0xEF5533)
    }
    
    static var tabItem: UIColor {
        return UIColor(hex: 0x9491AE)
    }
    
    static var _cdcdcd: UIColor {
        return UIColor(hex: 0xCDCDCD)
    }
    
    static var _282645: UIColor {
        return UIColor(hex: 0x282645)
    }
    
    static var _323266: UIColor {
        return UIColor(hex: 0x323266)
    }

    convenience init(hex: UInt) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb).uppercased()
    }
    
    func components() -> (CGFloat, CGFloat, CGFloat, CGFloat) {
        guard let c = cgColor.components else { return (0, 0, 0, 1) }
        if cgColor.numberOfComponents == 2 {
            return (c[0], c[0], c[0], c[1])
        } else {
            return (c[0], c[1], c[2], c[3])
        }
    }
    
    static func interpolate(from: UIColor, to: UIColor, with fraction: CGFloat) -> UIColor {
        let f = min(1, max(0, fraction))
        let c1 = from.components()
        let c2 = to.components()
        let r = c1.0 + (c2.0 - c1.0) * f
        let g = c1.1 + (c2.1 - c1.1) * f
        let b = c1.2 + (c2.2 - c1.2) * f
        let a = c1.3 + (c2.3 - c1.3) * f
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    static func hexStringToUIColor(hex: String?) -> UIColor {
        guard let hex = hex else { return .gray }
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.removeFirst()
        }

        if cString.count != 6 {
            return UIColor.gray // Return gray color for invalid input
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        let r = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgbValue & 0x0000FF) / 255.0

        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}
