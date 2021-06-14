//
//  Extensions.swift
//  Departures
//
//  Created by Namasang Yonzan on 11/06/21.
//

import Foundation

extension Date {

    func dateFormatWithSuffix() -> String {
        return "d'\(self.daySuffix())' MMM yyyy, h:mm a"
    }

    func daySuffix() -> String {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.day, from: self)
        let dayOfMonth = components.day
        switch dayOfMonth {
        case 1, 21, 31:
            return "st"
        case 2, 22:
            return "nd"
        case 3, 23:
            return "rd"
        default:
            return "th"
        }
    }
}
