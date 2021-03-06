//
//  Datetime.swift
//  DimigoinKitDemo
//
//  Created by 변경민 on 2021/01/26.
//

import Foundation

/// 월요일 ~ 일요일을 1~7 로 맵핑한 Enum
// FIXME: 월 ~ 일 0~6 리매핑 해야될듯..
public enum Weekday: Int {
    case today = 0
    case mon = 1
    case tue = 2
    case wed = 3
    case thu = 4
    case fri = 5
    case sat = 6
    case sun = 7
}

/// 내일의 Date를 반환
public func tomorrow() -> Date {
    var dateComponents = DateComponents()
    dateComponents.setValue(1, for: .day); // +1 day
    let now = Date() // Current date
    let tomorrow = Calendar.current.date(byAdding: dateComponents, to: now)  // Add the DateComponents
    return tomorrow!
}

/// 평일이면 True, 주말이면 False를 반환
public func isWeekday() -> Bool {
    let today = getTodayDayOfWeekString()
    if(today == "토" || today == "일") {
        return false
    }
    else {
       return true
    }
}

/// 오늘의 요일을 반환
public func getTodayDayOfWeekString() -> String {
    let now = Date()
    let date = DateFormatter()
    date.locale = Locale(identifier: "ko_kr")
    date.timeZone = TimeZone(abbreviation: "KST")
    date.dateFormat = "E"
    return date.string(from: now)
}

/// ["", "월", "화", "수", "목", "금", "토", "일"] : dayOfWeek[1] = 월
public let dayOfWeek: [String] = ["", "월", "화", "수", "목", "금", "토", "일"]

/// 월요일 ~ 일요일 까지를 1 ~ 7로 맵핑하여 반환
public func getTodayDayOfWeekInt() -> Int {
    var dayInt: Int = 0
    switch getTodayDayOfWeekString() {
        case "월": dayInt = 1
        case "화": dayInt = 2
        case "수": dayInt = 3
        case "목": dayInt = 4
        case "금": dayInt = 5
        case "토": dayInt = 6
        case "일": dayInt = 7
        default: return 0
    }
    return dayInt
}

/// MM월 dd일 N요일 반환
public func getDateString() -> String {
    let now = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ko_kr")
    dateFormatter.timeZone = TimeZone(abbreviation: "KST")
    dateFormatter.dateFormat = "M월 d일"

    return "\(dateFormatter.string(from: now)) \(getTodayDayOfWeekString())요일"
}

/// weekday에 따른 8 Digit date 반환(yyyyMMdd)
public func get8DigitDateString(_ weekday: Weekday) -> String {
    let amount = weekday.rawValue - getTodayDayOfWeekInt()
    let calendar = Calendar.current
    let date = calendar.date(byAdding: .day, value: amount, to: Date())
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: date!)
}

public func get8DigitDateString(from: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: from)
}

public func getDateString(from: Date) -> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "M월 d일"
    return dateFormatter.string(from: from)
}

/// 오늘의 8 Digit date 반환(yyyyMMdd)
public func getToday8DigitDateString() -> String {
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: date)
}

/// 해당 날짜의 요일을 반환합니다.(월 = 1 ~ 일 = 7 )
func getDayOfWeek(_ today:String) -> Int {
    let formatter  = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let todayDate = formatter.date(from: today)
    let myCalendar = Calendar(identifier: .gregorian)
    let weekDay = myCalendar.component(.weekday, from: todayDate!)
    return weekDay+1
}

/// HH시 mm분을 반환합니다.
public func getCurrentTimeString() -> String {
    let now = Date()

    let date = DateFormatter()
    date.locale = Locale(identifier: "ko_kr")
    date.timeZone = TimeZone(abbreviation: "KST") // "2018-03-21 18:07:27"
    date.dateFormat = "HH시 mm분"

    return date.string(from: now)
}

public func getStringTimeZone() -> String {
    let calendar = Calendar.current
    let now = Date()
    
    let AfterSchool1Start = calendar.date(
      bySettingHour: 17,
      minute: 10,
      second: 0,
      of: now)!
    
    let AfterSchool2Start = calendar.date(
      bySettingHour: 17,
      minute: 55,
      second: 0,
      of: now)!
    
    let DinnerTimeStart = calendar.date(
      bySettingHour: 18,
      minute: 35,
      second: 0,
      of: now)!
    
    let NSS1Start = calendar.date(
      bySettingHour: 19,
      minute: 50,
      second: 0,
      of: now)!

    let NSS2Start = calendar.date(
      bySettingHour: 21,
      minute: 10,
      second: 0,
      of: now)!
    
    let NSS2End = calendar.date(
      bySettingHour: 23,
      minute: 10,
      second: 0,
      of: now)!
    
    if now >= AfterSchool1Start && now <= AfterSchool2Start {
        return "방과후 1타임"
    }
    else if now >= AfterSchool2Start && now <= DinnerTimeStart {
        return "방과후 2타임"
    }
    else if now >= DinnerTimeStart && now <= NSS1Start {
        return "져녁시간"
    }
    else if now >= NSS1Start && now <= NSS2Start {
        return "야간자율학습 1타임"
    }
    else if now >= NSS2Start && now <=  NSS2End {
        return "야간자율학습 2타임"
    }
    return "학과시간"
}

public func UTC2KST(h: String, m: String) -> String {
    var hour: Int = Int(h)!
    if (hour + 9 >= 24) {
        hour = hour + 9 - 24
    } else {
        hour = hour + 9
    }
    return "\(hour):\(m)"
}


