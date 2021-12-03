//
//  Date+Format.swift
//  Expense Tracker
//
//  Created by Andy Nguyen on 1/12/21.
//

import Foundation
extension Date {
    func toStringWithDDMMMYYYYFormat()->String{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "dd MMM yyyy"
        formatter.timeZone = TimeZone(secondsFromGMT: 28800)
        return formatter.string(from: self)
    }
    
    func toStringWithhhmmDDMMMFormat()->String{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "hh:mm, dd MMM"
        formatter.timeZone = TimeZone(secondsFromGMT: 28800)
        return formatter.string(from: self)
    }
    
    func toStringWithhhmmFormat()->String{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "hh:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: 28800)
        return formatter.string(from: self)
    }
    
    func dateByAddingMore(days:Int) -> Date {
        var dayComponent    = DateComponents()
        dayComponent.day    = days
        let theCalendar     = Calendar.current
        return theCalendar.date(byAdding: dayComponent, to: self)!
    }
}
