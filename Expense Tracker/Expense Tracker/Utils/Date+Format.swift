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
    
    func toStringWithEdMMMFormat()->String{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "E, d MMM"
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
    
    func toStringWithHHmmFormat()->String{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: 28800)
        return formatter.string(from: self)
    }
    
    func dateByAddingMore(days:Int) -> Date {
        var dayComponent    = DateComponents()
        dayComponent.day    = days
        let theCalendar     = Calendar.current
        return theCalendar.date(byAdding: dayComponent, to: self)!
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func getPreviousMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -1, to: self)
    }
}
