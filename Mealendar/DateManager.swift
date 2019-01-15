//
//  DateManager.swift
//  Mealendar
//
//  Created by Hideaki Ito on 2019/01/15.
//  Copyright © 2019 Hideaki Ito. All rights reserved.
//

import UIKit

class DateManager: NSObject {
    
    var currentMonthOfDates = [Date]()
    var selectedDate = Date()
    let daysPerWeek: Int = 7
    var numberOfItems: Int!
    
    func daysAcquisition() -> Int {
        let rangeOfWeeks = NSCalendar(identifier: .gregorian)?.range(of: NSCalendar.Unit.weekOfMonth, in: NSCalendar.Unit.month, for: firstDateOfMonth())
        let numberOfWeeks = rangeOfWeeks?.length
        numberOfItems = numberOfWeeks! * daysPerWeek
        
        return numberOfItems
    }
    
    func firstDateOfMonth() -> Date {
        var components = NSCalendar(identifier: .gregorian)?.components([.year, .month, .day], from: selectedDate)
        components?.day = 1
        let firstDateMonth = NSCalendar(identifier: .gregorian)?.date(from: components!)!
        return firstDateMonth!
    }
    
    func dateForCellAtIndexPath(numberOfItems: Int) {
        let ordinalityOfFirstDay = NSCalendar(identifier: .gregorian)?.ordinality(of: NSCalendar.Unit.day, in: NSCalendar.Unit.weekOfMonth, for: firstDateOfMonth())
        for i in 0 ..< numberOfItems {
            var dateComponents = DateComponents()
            dateComponents.day = i - (ordinalityOfFirstDay! - 1)
            
            let date = NSCalendar(identifier: .gregorian)?.date(byAdding: dateComponents, to: firstDateOfMonth(), options: NSCalendar.Options(rawValue: 0))!
            
            NSLog("hoge")
            currentMonthOfDates.append(date!)
        }
    }
    
    func conversionDateFormat(indexPath: IndexPath) -> String {
        dateForCellAtIndexPath(numberOfItems: numberOfItems)
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: currentMonthOfDates[indexPath.row])
    }
    
    func prevMonth(date: Date) -> Date {
        currentMonthOfDates = []
        selectedDate = date.monthAgoDate()
        return selectedDate
    }
    
    func nextMonth(date: Date) -> Date {
        currentMonthOfDates = []
        selectedDate = date.monthLaterDate()
        return selectedDate
    }
}

extension Date {
    func monthAgoDate() -> Date {
        let addValue = -1
        let calendar = NSCalendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.month = addValue
        return (calendar?.date(byAdding: dateComponents, to: self, options: NSCalendar.Options(rawValue: 0))!)!
    }
    
    func monthLaterDate() -> Date {
        let addValue: Int = 1
        let calendar = NSCalendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.month = addValue
        return (calendar?.date(byAdding: dateComponents, to: self, options: NSCalendar.Options(rawValue: 0))!)!
    }
}
