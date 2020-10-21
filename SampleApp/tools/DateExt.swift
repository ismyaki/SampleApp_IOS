//
//  DateExt.swift
//  TRAQ
//
//  Created by Aki Wang on 2020/2/11.
//  Copyright © 2020 smartq. All rights reserved.
//

import Foundation

class DateTool {
    static let oneSec = 1.0
    static let oneMin = oneSec * 60.0
    static let oneHour = oneMin * 60.0
    static let oneDay = oneHour * 24.0
    static let oneWeek = oneDay * 7.0
    static let oneMonth = oneDay * 30.0
    static let oneYear = oneDay * 365.0
    
    static let oneSecInt = (oneSec * 1000).toInt()
    static let oneMinInt = (oneMin * 1000).toInt()
    static let oneHourInt = (oneHour * 1000).toInt()
    static let oneDayInt = (oneDay * 1000).toInt()
    static let oneWeekInt = (oneWeek * 1000).toInt()
    static let oneMonthInt = (oneMonth * 1000).toInt()
    static let oneYearInt = (oneYear * 1000).toInt()
}

extension Int {
    func toDate() -> Date{
        return Date(self)
    }
}

extension Int64 {
    func toDate() -> Date{
        return Date(self)
    }
}

extension Double {
    func toDate() -> Date{
        return Date(self)
    }
}

extension String {
    func toDate(_ dateFormat: String, timeZone: TimeZone? = TimeZone.current) -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = timeZone
        return dateFormatter.date(from: self)
    }

    func toDateNonNil(_ dateFormat: String, _ def: Date = Date(0)) -> Date{
        return toDate(dateFormat) ?? def
    }
}

extension TimeZone {
    init?(_ identifier: String) {
        self.init(identifier: identifier)
    }
    
    init?(_ secondsFromGMT: Int) {
        self.init(secondsFromGMT: secondsFromGMT)
    }
}

extension Date {
    
    init(_ year: Int, _ month: Int, _ day: Int, _ hour: Int = 0, _ minute: Int = 0, _ second: Int = 0, _ nanosecond: Int = 0){
        var dateComponents = DateComponents()
        dateComponents.year = 1980
        dateComponents.month = 7
        dateComponents.day = 11
        dateComponents.hour = 8
        dateComponents.minute = 34
        dateComponents.second = second
        dateComponents.nanosecond = nanosecond
        dateComponents.timeZone = TimeZone.current

        // Create date from components
        let userCalendar = Calendar.current
        self = userCalendar.date(from: dateComponents) ?? Date()
    }
    
    init(_ timeIntervalSince1970: Double){
        self.init(timeIntervalSince1970: timeIntervalSince1970)
    }
    
    init(_ milliseconds: Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
    
    init(_ milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(Int(milliseconds) / 1000))
    }
    
    var millisecondsSince1970 : Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    func string(format: String) -> String{
        let df = DateFormatter()
        df.dateFormat = format
        return df.string(from: self)
    }
    
    
    func toString(_ format: String, timeZone: TimeZone? = TimeZone.current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = timeZone
        return dateFormatter.string(from: self)
    }
    
    /** 常用的時間格式 yyyy-MM-dd HH:mm:ss */
    func logTime() -> String{
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss:sss"
        return df.string(from: self)
    }
    
    func daysBetweenDate(toDate: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: self, to: toDate)
        return components.day ?? 0
    }
    
    /**
    * 時區轉換
    * @author wang
    * @date 2020/02/10
    * @param timeZone 指定時區
    * */
    func toTimeZone(_ timeZone: TimeZone) -> Date{
        let date = Date(self.millisecondsSince1970 + (timeZone.secondsFromGMT() * 1000))
//        if timeZone.isDaylightSavingTime(for: date) {
//            date = Date(date.timeIntervalSince1970 - timeZone.daylightSavingTimeOffset())
//        }
        return date
    }
    
    /**
    * 時區轉換
    * @author wang
    * @date 2020/02/10
    * @param frome 從指定時區
    * @param to 轉換到指定時區
    * */
    func toTimeZone(_ frome: TimeZone, _ to: TimeZone) -> Date{
        return toTimeZone(frome).toTimeZone(to)
    }
    
    /**
    * 時區轉換成+0
    * @author wang
    * @date 2020/02/10
    * @param timeZone date的時區
    * */
    func toGMT(_ timeZone: TimeZone = TimeZone.current) -> Date{
//        var date = Date(self.timeIntervalSince1970 + (timeZone.secondsFromGMT().toDouble()))
//        if isDayLight == false && timeZone.isDaylightSavingTime(for: date) {
//            date = Date(date.timeIntervalSince1970 - timeZone.daylightSavingTimeOffset())
//        }
//        return date
        return Date(self.timeIntervalSince1970 + (timeZone.secondsFromGMT().toDouble()))
    }
    
    func toGMT2(_ timeZone: TimeZone = TimeZone.current) -> Date{
        let format = "yyyy-MM-dd HH:mm:ss:SSS"
        return self.toString(format).toDate(format, timeZone: TimeZone("GMT")) ?? self
    }
    
    /**
    * 時區轉換成+0
    * @author wang
    * @date 2020/02/10
    * @param timeZone date的時區
    * */
    func toGMT(_ timeZoneId: String) -> Date{
        return toGMT(TimeZone.init(identifier: timeZoneId) ?? TimeZone.current)
    }
    
    /**
    * 時區轉換成當地時區
    * @author wang
    * @date 2020/02/10
    * @param timeZone 要轉的時區
    * */
    func toLocal(_ timeZone: TimeZone = TimeZone.current) -> Date{
        return toTimeZone(timeZone)
    }
    
    func Local2UTC() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss:SSS"
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        
        guard let date = dateFormatter.date(from: self.string(format: "yyyy-MM-dd HH:mm:ss:SSS")) else {
            return nil
        }
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss:SSS"
        return dateFormatter.string(from: date).toDate("yyyy-MM-dd HH:mm:ss:SSS")
    }
    
    func UTC2Local() -> Date? {
        let str = string(format: "yyyy-MM-dd HH:mm:ss:SSS")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss:SSS"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let date = dateFormatter.date(from: str)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss:SSS"
        return dateFormatter.date(from: date?.string(format: "yyyy-MM-dd HH:mm:ss:SSS") ?? "")
    }
    /** 一天的開始時間 */
    func getStartOfDay() -> Date {
        return Calendar.current.startOfDay(for: self)
    }
    /** 一天的結束時間 */
    func getEndOfDay() -> Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to:getStartOfDay())!
    }
    
    /** 一周的第一天 */
    func getWeekStartDay() -> Date {
        let gregorian = Calendar(identifier: .gregorian)
        return gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
    }
    
    /** 一周的最後一天 */
    func getWeekEndDay() -> Date {
        return getWeekStartDay().adding(.day, value: 6)
    }
    
    /** 一個月的第一天 */
    func getMonthStartDay() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    /** 一個月的最後一天 */
    func getMonthEndDay() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.getMonthStartDay())!
    }
    
    /** 一季的第一天 */
    func getSeasonStartDay() -> Date {
        var season = 0
        if month >= 1 && month <= 3 {
            season = 0
        } else if month >= 4 && month <= 6 {
            season = 1
        } else if month >= 7 && month <= 9 {
            season = 2
        } else if month >= 10 && month <= 12 {
            season = 3
        }
        return (Date(year: year, month: season * 3 + 1)?.getMonthStartDay())!
    }
    
    /** 一季的最後一天 */
    func getSeasonEndDay() -> Date {
        var season = 0
        if month >= 1 && month <= 3 {
            season = 0
        } else if month >= 4 && month <= 6 {
            season = 1
        } else if month >= 7 && month <= 9 {
            season = 2
        } else if month >= 10 && month <= 12 {
            season = 3
        }
        return (Date(year: year, month: season * 3 + 3)?.getMonthEndDay())!
    }
    
    /** 一年的第一天 */
    func getYearStartDay() -> Date {
        let gregorian = Calendar(identifier: .gregorian)
        return gregorian.date(from: gregorian.dateComponents([.year], from: self))!
    }
    
    /** 一年的最後一天 */
    func getYearEndDay() -> Date {
        return Calendar.current.date(byAdding: DateComponents(year: 1, day: -1), to: self.getYearStartDay())!
    }
    
    /** 一年的第幾週 */
    func weekOfYear() -> Int{
        var date = getYearStartDay().getWeekEndDay()
        var week = 1
        while date.timeIntervalSince1970 < self.timeIntervalSince1970 {
            date = date.adding(.day, value: 1).getWeekEndDay()
            week += 1
        }
        return week
    }
    
    /** 一個月的第幾週 */
    func weekOfMonth() -> Int{
        guard let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian) else {
            return 0
        }
        let components = calendar.components([.weekOfYear,.weekOfMonth,.weekday,.weekdayOrdinal], from: self)
        return components.weekOfMonth ?? 0
    }
    
    /** 星期幾 */
    func dayOfWeek() -> Int{
        guard let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian) else {
            return 0
        }
        let components = calendar.components([.weekday], from: self)
        return (components.weekday ?? 1) - 1
    }
    
    func stringToDate(date: String, dateFormat: String) -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: date)
    }
    
    func removeHourMinuteTime() -> Date {
        var date = self.timeIntervalSince1970.toDate()
        date.hour = 0
        date.minute = 0
        date.second = 0
        date.millisecond = 0
        date.nanosecond = 0
        return date
    }
    
    func getDateToday() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = .current
        return dateFormatter.date(from: dateFormatter.string(from: self))
    }

}
