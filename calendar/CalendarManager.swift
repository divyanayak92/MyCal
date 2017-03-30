//
//  CalendarManager.swift
//  calendar
//
//  Created by Divya Nayak on 13/06/16.
//  Copyright © 2016 Aspire. All rights reserved.
//

import Foundation

class CalendarManager : NSObject {

    var weekdays:NSArray!
    var currentMonth:Date!
    
    override init(){
        super.init()
        getToday()
        initialiseWeekDays()
    }
    
    func getToday(){
        currentMonth = Date().today()
    }
    
    func dayForDate(date:Date) -> NSInteger {
       return currentMonth.dayForDate(date: date)
    }
    
    func monthForDate(date:Date) -> NSInteger {
        return currentMonth.monthForDate(date: date)
    }
    
    func yearForDate(date:Date) -> NSInteger {
        return currentMonth.yearForDate(date: date)
    }
    
    func stringForDay(_ day:Int) -> String{
      return weekdays.object(at: day) as! String
    }
    
    func initialiseWeekDays(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        weekdays = dateFormatter.shortWeekdaySymbols as NSArray!
    }
    
    func firstWeekDayOfMonth() -> Int{
        return self.currentMonth.firstWeekDayOfMonth()
    }
    
    func date(day:NSInteger,month:NSInteger,year:NSInteger) -> Date{
        return currentMonth.date(day: day, month: month, year: year)
    }
    
    func numberOfDaysInMonth() -> Int{
        return self.currentMonth.numDaysInMonth()
    }
    
    func offsetMonths(_ offset:NSInteger){
        currentMonth = self.currentMonth.offsetMonth(offset)
    }
    
    func currentMonthAndYear() -> String{
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MMMM yyyy"
        return dateFormater.string(from: currentMonth)
    }
}
