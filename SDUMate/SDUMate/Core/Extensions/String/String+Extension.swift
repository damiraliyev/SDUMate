//
//  String+Extension.swift
//  BePRO
//
//  Created by Yessenali Zhanaidar on 04.07.2023.
//

import UIKit

public extension String {
    func makeAttributedText( _ font: UIFont, _ textColor: UIColor?, alignment: NSTextAlignment = .left, _ lineSpacing: CGFloat = 0, kern: Double = -0.3) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = alignment
        attributedString.append(NSAttributedString(string: self, attributes: [.font: font, .foregroundColor: textColor, .paragraphStyle: paragraphStyle, .kern: kern]))
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        return attributedString
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        )
        return ceil(boundingBox.width)
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        )
        return boundingBox.height
    }
    
    func convert(fromFormat: String, toFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = UserSettings().appLanguage.locale
        dateFormatter.dateFormat = fromFormat
        guard let date = dateFormatter.date(from: self) else {
            print("Invalid date or format: \(self), \(fromFormat)")
            return ""
        }
        dateFormatter.dateFormat = toFormat
        return dateFormatter.string(from: date)
    }

    func dayFromDate(format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: self) else { return nil }
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: date)
    }
    
    func doubleValue() -> Double {
        let value = Double(components(separatedBy: CharacterSet(charactersIn: "-0123456789.").inverted).joined(separator: ""))
        return value ?? 0.0
    }
    
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self) ?? Date()
    }
    
    func yearFromFormat(format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ") -> Int? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        if let date = formatter.date(from: self) {
            let year = Calendar.current.component(.year, from: date)
            return year
        }
        return nil
    }
    
    func getMonthNumber() -> Int {
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from: self) ?? Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: date)
        return components.month!
    }
    
    func stripSecondsIfNeeded() -> String {
        let parts = self.split(separator: ":")
        if parts.count >= 2 {
            return "\(parts[0]):\(parts[1])"
        } else {
            return self
        }
    }
    
    var isNotEmpty: Bool {
        !self.isEmpty
    }
    
    func toSeconds() -> Int {
        let components = self.split(separator: ":").compactMap { Int($0) }
        if components.count == 2 {
            return components[0] * 3600 + components[1] * 60
        }
        return 0
    }

    func toDate(format: String = "HH:mm:ss") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    
    func convertISOToDate() -> Date {
        let formatterWithFractionalSeconds = ISO8601DateFormatter()
        formatterWithFractionalSeconds.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let formatterWithoutFractionalSeconds = ISO8601DateFormatter()
        formatterWithoutFractionalSeconds.formatOptions = [.withInternetDateTime]
        if let dateWithFraction = formatterWithFractionalSeconds.date(from: self) {
            return dateWithFraction
        } else if let dateWithoutFraction = formatterWithoutFractionalSeconds.date(from: self) {
            return dateWithoutFraction
        } else {
            return Date()
        }
    }
    
    func extractTimeAsString(formats: [String]) -> Self? {
        let dateFormats = formats
        for format in dateFormats {
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone.autoupdatingCurrent
            dateFormatter.dateFormat = format
            if let date = dateFormatter.date(from: self) {
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: date)
                let minute = calendar.component(.minute, from: date)
                let second = calendar.component(.second, from: date)
                return String(format: "%02d:%02d:%02d", hour, minute, second)
            }
        }
        return nil
    }
    
    func changeDateFormat(from oldFormat: String, to newFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.long
        dateFormatter.dateFormat = oldFormat
        guard let convertedDate = dateFormatter.date(from: self) else { return nil }
        dateFormatter.dateFormat = newFormat
        let date = dateFormatter.string(from: convertedDate)
        return date
    }
    
    func convertDateToString(using dateFormat: String = "HH:mm, dd.MM.yyyy") -> String {
        let formatterWithFractionalSeconds = ISO8601DateFormatter()
        formatterWithFractionalSeconds.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        let formatterWithoutFractionalSeconds = ISO8601DateFormatter()
        formatterWithoutFractionalSeconds.formatOptions = [.withInternetDateTime]
        
        var parsedDate: Date?
        
        if let dateWithFraction = formatterWithFractionalSeconds.date(from: self) {
            parsedDate = dateWithFraction
        } else if let dateWithoutFraction = formatterWithoutFractionalSeconds.date(from: self) {
            parsedDate = dateWithoutFraction
        }
        
        var deadlineDate: String = ""
        if let date = parsedDate {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = dateFormat
            deadlineDate = outputFormatter.string(from: date)
        }
        return deadlineDate
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func formatAmountString() -> String {
        var tempString = self

        if tempString.count > 3 {
            tempString.insert(Character(" "), at: tempString.getIndexFromEnd(at: 3))
        }
        if tempString.count > 7 {
            tempString.insert(Character(" "), at: tempString.getIndexFromEnd(at: 7))
        }
        if tempString.count > 11 {
            tempString.insert(Character(" "), at: tempString.getIndexFromEnd(at: 11))
        }

        if tempString.count > 15 {
            tempString.insert(Character(" "), at: tempString.getIndexFromEnd(at: 15))
        }
        return tempString
    }
    
    func getIndexFromEnd(at: Int) -> String.Index {
        return index(endIndex, offsetBy: -at)
    }
    
    static func getKazakhSuffixForFromDate(dayString: String) -> String {
        guard dayString != "",
              let lastDigit = String.getLastDayDigitFromDate(dateString: dayString) else { return "" }
        let hardSoundSuffix = "-нан"
        let softSoundSuffix = "-нен"
        switch lastDigit {
        case 0, 6, 9: return hardSoundSuffix
        default: return softSoundSuffix
        }
    }
    
    static func getKazakhSuffixForToDate(dayString: String) -> String {
        guard dayString != "",
              let lastDigit = String.getLastDayDigitFromDate(dateString: dayString) else { return "" }
        let hardSoundSuffix = "-на"
        let softSoundSuffix = "-не"
        switch lastDigit {
        case 0, 6, 9: return hardSoundSuffix
        default: return softSoundSuffix
        }
    }
    
    
    static func getLastDayDigitFromDate(dateString: String) -> Int? {
        var lastDigit: Int? = nil
        for character in dateString {
            if let digit = Int(String(character)) {
                lastDigit = digit
            } else {
                break
            }
        }
        return lastDigit
    }

    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
    
    func getTimeZone() -> TimeZone {
        let offsetString = self
        let offsetComponents = offsetString.components(separatedBy: ":")
        if offsetComponents.count == 2,
           let hours = Int(offsetComponents[0]),
           let minutes = Int(offsetComponents[1]) {
            let secondsFromGMT = (hours * 3600) + (minutes * 60)
            return TimeZone(secondsFromGMT: secondsFromGMT) ?? TimeZone.current
        } else {
            print("Unexpected time zone offset format: \(offsetString). Using default time zone.")
            return TimeZone.current
        }
    }
    
    func convertToTimeDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.date(from: self)
    }
}
