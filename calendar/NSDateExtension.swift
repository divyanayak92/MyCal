//
//  DateExtension.swift
//  calendar
//
//  Created by Divya Nayak on 13/06/16.
//  Copyright © 2016 Aspire. All rights reserved.
//

import Foundation

extension Date{
    
    func defaultCalendar() -> Calendar{
        var calendar : Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.firstWeekday = 1
        return calendar
    }
    
    func today() -> Date{
        let calendar : Calendar = defaultCalendar()
        let components : DateComponents = (calendar as NSCalendar).components([.year,.month,.day], from: self)
        return calendar.date(from: components)!
    }
    
    func dayForDate(date:Date) -> NSInteger{
        let calendar : Calendar = defaultCalendar()
        let components : DateComponents = (calendar as NSCalendar).components([.day], from: date as Date)
        return components.day!
    }
    
    func monthForDate(date:Date) -> NSInteger {
        let calendar : Calendar = defaultCalendar()
        let components : DateComponents = (calendar as NSCalendar).components([.month], from: date as Date)
        return components.month!
    }
    
    func yearForDate(date:Date) -> NSInteger {
        let calendar : Calendar = defaultCalendar()
        let components : DateComponents = (calendar as NSCalendar).components([.year], from: date as Date)
        return components.year!
    }
    
    func firstWeekDayOfMonth() -> Int{
        let calendar : Calendar = defaultCalendar()
        var components : DateComponents = (calendar as NSCalendar).components([.year,.month,.day], from: self)
        components.day = 1
        let newDate : Date = calendar.date(from: components)!
        return (calendar as NSCalendar).ordinality(of: NSCalendar.Unit.weekday, in:NSCalendar.Unit.weekOfMonth, for: newDate)
    }
    
    func date(day:NSInteger, month:NSInteger, year:NSInteger) -> Date{
        let calendar : Calendar = defaultCalendar()
        var components : DateComponents = DateComponents()
        components.day = day
        components.month = month
        components.year = year
        return calendar.date(from: components)!
    }
    
    func numDaysInMonth() -> Int{
        let calendar : Calendar = Calendar.current
        let range : NSRange = (calendar as NSCalendar).range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: self)
        let numberOfDaysInMonth = range.length
        return numberOfDaysInMonth
    }

    func offsetMonth(_ numberOfMonths:NSInteger) -> Date{
        let calendar = defaultCalendar()
        var offsetComponents : DateComponents = DateComponents()
        offsetComponents.month = numberOfMonths
        return (calendar as NSCalendar).date(byAdding: offsetComponents, to: self, options:[])!
    }
}
