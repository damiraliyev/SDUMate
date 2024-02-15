//
//  Date+Extension.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 10.07.2023.
//

import Foundation

extension Date {
    enum Constants {
        static let defaultTimeZone = "GMT+6:00"
        static let ddMMYYYYWithDot = "dd.MM.yyyy"
        static let ddMMYYYYWithSpace = "dd MMM yyyy"
        static let lastHour = 23
        static let lastMinute = 59
    }
    static var dateFormatter = DateFormatter()
    
    static var calendar: Calendar {
        var calendar = Calendar.current
        calendar.timeZone = .autoupdatingCurrent
        calendar.locale = UserSettings().appLanguage.locale
        return calendar
    }
    
    static var gmtCalendar: Calendar {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "GMT+0:00")!
        calendar.locale = Locale(identifier: "ru_RU")
        return calendar
    }
    
    func toString(format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = UserSettings().appLanguage.locale
        dateFormatter.timeZone = TimeZone(abbreviation: getCurrentTimeZone())
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func toStringWithoutTimeZone(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = UserSettings().appLanguage.locale
        return dateFormatter.string(from: self)
    }
    
    func toUTCString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter.string(from: self)
    }
    
    static var currentDate: String {
        let now = Date()
        let currentTimeZone = getCurrentTimeZone(now)
        dateFormatter.timeZone = TimeZone(abbreviation: currentTimeZone())
        dateFormatter.locale = Locale(identifier: "ru_Ru")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: now)
    }
    
    static var currentDateInDayMonthYear: String {
        let now = Date()
        let currentTimeZone = getCurrentTimeZone(now)
        dateFormatter.timeZone = TimeZone(abbreviation: currentTimeZone())
        dateFormatter.locale = UserSettings().appLanguage.locale
        dateFormatter.dateFormat = Constants.ddMMYYYYWithDot
        return dateFormatter.string(from: now)
    }
    
    static var yesterdayDateInDayMonthYear: String {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
        dateFormatter.dateFormat = Constants.ddMMYYYYWithDot
        return dateFormatter.string(from: yesterday)
    }
    
    func getCurrentTimeZone() -> String {
        let localTimeZoneAbbreviation: Int = TimeZone.current.secondsFromGMT()
        let hour = localTimeZoneAbbreviation / 3600
        let minute = abs(localTimeZoneAbbreviation) / 60 % 60
        return String(format: "%+.2d:%.2d", hour, minute)
    }
    
    static var currentTime: String {
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.locale = UserSettings().appLanguage.locale
        return dateFormatter.string(from: Date())
    }
    
    var seconds: Int64 {
        return Int64((self.timeIntervalSince1970).rounded())
    }
    
    var startOfDay: Date {
        return Date.calendar.startOfDay(for: self)
    }
    
    func startOfNextMonth() -> Date {
        return Date.gmtCalendar.date(byAdding: DateComponents(month: 1), to: startOfMonth())!
    }
    
    func toString(dateFormat format: String, GMT: String = "+6:00") -> String {
        Date.dateFormatter.dateFormat = format
        Date.dateFormatter.locale = UserSettings().appLanguage.locale
        Date.dateFormatter.timeZone = TimeZone(abbreviation: "GMT\(GMT)")
        return Date.dateFormatter.string(from: self)
    }
    
    func toMonthFullNameString() -> String {
        let formatter = DateFormatter()
        formatter.locale = UserSettings().appLanguage.locale
        formatter.dateFormat = Constants.ddMMYYYYWithSpace
        return formatter.string(from: self)
    }
    
    func toMonthShortNameString() -> String {
        let formatter = DateFormatter()
        formatter.locale = UserSettings().appLanguage.locale
        formatter.dateFormat = Constants.ddMMYYYYWithSpace
        return formatter.string(from: self)
    }
    
    func startOfMonth() -> Date {
        var components = Calendar.current.dateComponents([.year,.month], from: self)
        components.day = 1
        let firstDateOfMonth: Date = Calendar.current.date(from: components)!
        return firstDateOfMonth
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func currentYearString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY"
        let currentYear = formatter.string(from: self)
        return currentYear
    }
    
    static func getCurrentYear() -> Int {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: date)
        return components.year ?? 0
    }
    
    func getMonth() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: self)
        return components.month ?? 1
    }
    
    func getWeekdayAndDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMMM"
        dateFormatter.locale = UserSettings().appLanguage.locale
        let dateString = dateFormatter.string(from: self).capitalized
        return dateString
    }
    
    func weekday() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: self)
        return components.weekday?.toEuropeanWeekDay() ?? 1
    }
    
    func day() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        formatter.locale = UserSettings().appLanguage.locale
        let dayAndWeekday = formatter.string(from: self)
        return dayAndWeekday
    }
    
    var lastMomentOfDay: Date {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        components.hour = Constants.lastHour
        components.minute = Constants.lastMinute
        return Calendar.current.date(from: components) ?? self
    }
    
    static func fromISO8601String(_ dateString: String) -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return dateFormatter.date(from: dateString)
    }
}

extension Date {
    func convertToTimeZone(initTimeZone: TimeZone, timeZone: TimeZone) -> Date {
         let delta = TimeInterval(timeZone.secondsFromGMT(for: self) - initTimeZone.secondsFromGMT(for: self))
         return addingTimeInterval(delta)
    }
}

