//
//  Int+Extension.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 14.07.2023.
//

import Foundation

extension Int {
    func toEuropeanWeekDay() -> Int {
        return self == 1 ? 7 : self - 1
    }
    
    func getFormattedDuration() -> String {
        let hours = self / 3600
        let minutes = self / 60
        let seconds = self % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
