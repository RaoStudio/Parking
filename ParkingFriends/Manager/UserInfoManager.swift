//
//  UserInfoManager.swift
//  ParkingFriends
//
//  Created by MyoungHyoun Cho on 2018. 5. 14..
//  Copyright © 2018년 rao. All rights reserved.
//

import Foundation
import SwiftDate
import CoreLocation

struct UserInfoKey {
    static let tutorial = "TUTORIAL"
    static let radius = "RADIUS"
    static let startTime = "STARTTIME"
    static let endTime = "ENDTIME"
    static let isUserAlarm = "ISUSERALARM"
    static let UserAlarmStart = "USERALARMSTART"
    static let UserAlarmEnd = "USERALARMEnd"
    
    
    static let endHours = "ENDHOURS"
    static let nIndexEnd = "NINDEXEND"
    
    
    static let extendStartTime = "EXTENDSTARTTIME"
    static let extendEndTime = "EXTENDENDTIME"
    
    
    static let firstTime = "FIRST_TIME"
    static let secondTime = "SECOND_TIME"
    static let thirdTime = "THIRD_TIME"
    
    
    static let nFirstTime = "INDEX_FIRST_TIME"
    static let nLastTime = "INDEX_LAST_TIME"
    
    static let rLatitude = "RESERVE_LATITUDE"
    static let rLongtitude = "RESERVE_LONGITUDE"
    static let rCompany = "RESERVE_COMPANY"
    static let rLocation = "RESERVE_LOCATION"       // Not Use
    
    static let totalPay = "TOTALPAY"
    static let lastPay = "LASTPAY"
    
    static let rsvType = "RSVTYPE"
    static let lotSid = "LOTSID"
    static let extend = "EXTEND"
    
    static let creditOne = "CREDIT_ONE"
    static let creditTwo = "CREDIT_TWO"
    static let creditThree = "CREDIT_THREE"
    static let creditFour = "CREDIT_FOUR"
    static let creditMonth = "CREDIT_MONTH"
    static let creditYear = "CREDIT_YEAR"
}


class UserInfoManager {
    
    var day = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"]
    
    var radius: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.radius)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserInfoKey.radius)
            ud.synchronize()
        }
    }
    
    var startTime: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.startTime)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserInfoKey.startTime)
            ud.synchronize()
        }
    }
    
    var endTime: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.endTime)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserInfoKey.endTime)
            ud.synchronize()
        }
    }
    
    var endHours: Int? {
        get {
            return UserDefaults.standard.integer(forKey: UserInfoKey.endHours)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserInfoKey.endHours)
            ud.synchronize()
        }
    }
    
    var nIndexEnd: Int? {
        get {
            return UserDefaults.standard.integer(forKey: UserInfoKey.nIndexEnd)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserInfoKey.nIndexEnd)
            ud.synchronize()
        }
    }
    
    var extendStartTime: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.extendStartTime)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserInfoKey.extendStartTime)
            ud.synchronize()
        }
    }
    
    
    var extendEndTime: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.extendEndTime)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserInfoKey.extendEndTime)
            ud.synchronize()
        }
    }
    
    var isUserAlarm: Bool? {
        get {
            return UserDefaults.standard.bool(forKey: UserInfoKey.isUserAlarm)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserInfoKey.isUserAlarm)
            ud.synchronize()
        }                
    }
    
    
    var UserAlarmStart: Int? {
        get {
            return UserDefaults.standard.integer(forKey: UserInfoKey.UserAlarmStart)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserInfoKey.UserAlarmStart)
            ud.synchronize()
        }
    }
    
    var UserAlarmEnd: Int? {
        get {
            return UserDefaults.standard.integer(forKey: UserInfoKey.UserAlarmEnd)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserInfoKey.UserAlarmEnd)
            ud.synchronize()
        }
    }
    
    var rLatitude: Double? {
        get {
            return UserDefaults.standard.double(forKey: UserInfoKey.rLatitude)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserInfoKey.rLatitude)
            ud.synchronize()
        }
    }
    
    
    var rLongtitude: Double? {
        get {
            return UserDefaults.standard.double(forKey: UserInfoKey.rLongtitude)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserInfoKey.rLongtitude)
            ud.synchronize()
        }
    }
    
    var rCompany: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.rCompany)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserInfoKey.rCompany)
            ud.synchronize()
        }
    }
    
    var rLocation: CLLocationCoordinate2D? {
        get {
            return UserDefaults.standard.object(forKey: UserInfoKey.rLocation) as? CLLocationCoordinate2D
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserInfoKey.rLocation)
            ud.synchronize()
        }
    }
    
    
    var totalPay: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.totalPay)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserInfoKey.totalPay)
            ud.synchronize()
        }
    }
    
    var lastPay: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.lastPay)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserInfoKey.lastPay)
            ud.synchronize()
        }
    }
    
    var extend: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.extend)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserInfoKey.extend)
            ud.synchronize()
        }
    }
    
    var lotSid: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.lotSid)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserInfoKey.lotSid)
            ud.synchronize()
        }
    }
    
    var rsvType: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.rsvType)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserInfoKey.rsvType)
            ud.synchronize()
        }
    }
    
    var creditOne: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.creditOne)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserInfoKey.creditOne)
            ud.synchronize()
        }
    }
    
    var creditTwo: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.creditTwo)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserInfoKey.creditTwo)
            ud.synchronize()
        }
    }
    
    var creditThree: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.creditThree)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserInfoKey.creditThree)
            ud.synchronize()
        }
    }
    
    var creditFour: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.creditFour)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserInfoKey.creditFour)
            ud.synchronize()
        }
    }
    
    var creditMonth: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.creditMonth)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserInfoKey.creditMonth)
            ud.synchronize()
        }
    }
    
    var creditYear: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.creditYear)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserInfoKey.creditYear)
            ud.synchronize()
        }
    }
    
    
    var firstTime: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.firstTime)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserInfoKey.firstTime)
            ud.synchronize()
        }
    }
    
    var secondTime: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.secondTime)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserInfoKey.secondTime)
            ud.synchronize()
        }
    }
    
    var thirdTime: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.thirdTime)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserInfoKey.thirdTime)
            ud.synchronize()
        }
    }
    
    var nFirstTime: Int? {
        get {
            return UserDefaults.standard.integer(forKey: UserInfoKey.nFirstTime)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserInfoKey.nFirstTime)
            ud.synchronize()
        }
    }
    
    var nLastTime: Int? {
        get {
            return UserDefaults.standard.integer(forKey: UserInfoKey.nLastTime)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserInfoKey.nLastTime)
            ud.synchronize()
        }
    }
}

extension UserInfoManager {

/*
    func initTime() {
        
        // Time Set
        let nowDate = Date()
        var nowDatePlus10 = nowDate + 10.minute
        
        let min10 = (nowDatePlus10.minute / 10) * 10
        
        nowDatePlus10 = nowDatePlus10 - nowDatePlus10.minute.minute + min10.minute
        
        let dateAfterNow = Date(timeInterval: 60*60, since: nowDatePlus10)
        let strNowDate = dateToString(nowDatePlus10)
        let strDateAfterNow = dateToString(dateAfterNow)
        
        startTime = strNowDate
        endTime = strDateAfterNow
        endHours = 1
        nIndexEnd = 0
     
        UserAlarmStart = 0
        UserAlarmEnd = 0
    }
 */
    
    
    func initTime() {
        
        // Time Set
        let nowDate = Date()
        var nowDatePlus10 = nowDate + 10.minute
        
        let min10 = (nowDatePlus10.minute / 10) * 10
        
        nowDatePlus10 = nowDatePlus10 - nowDatePlus10.minute.minute + min10.minute
        
        let dateAfterNow = Date(timeInterval: 2*60*60, since: nowDatePlus10)
        let strNowDate = dateToString(nowDatePlus10)
        let strDateAfterNow = dateToString(dateAfterNow)
        
        startTime = strNowDate
        endTime = strDateAfterNow
        endHours = 2
        nIndexEnd = 0
        
        
//        UserAlarmStart = 0
//        UserAlarmEnd = 0
    }
    
    
    func initTimePickerVCTime() {
        firstTime = startTime
        let dateFirst = stringToDate(firstTime!)
        let dateSecond = dateFirst + 1.day
        let dateThird = dateFirst + 2.day
        
        secondTime = dateToString(dateSecond)
        thirdTime = dateToString(dateThird)
        
        nFirstTime = 0
        nLastTime = 0
        nIndexEnd = 0
        
//        UserAlarmStart = 0
//        UserAlarmEnd = 0
    }
    
    func stringToDate(_ value: String) -> Date {
        let df = DateFormatter()
//        df.locale = Locale(identifier: "ko_KR")
        df.locale = Locale.current
        df.timeZone = TimeZone.current
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return df.date(from: value)!
    }
    
    func dateToString(_ value: Date) -> String {
        let df = DateFormatter()
//        df.locale = Locale(identifier: "ko_KR")
        df.locale = Locale.current
        df.timeZone = TimeZone.current
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return df.string(from: value as Date)
    }
    
    func dateToStringForCheck(_ value: Date) -> String {
        let df = DateFormatter()
        //        df.locale = Locale(identifier: "ko_KR")
        df.locale = Locale.current
        df.timeZone = TimeZone.current
        df.dateFormat = "yyyyMMddHHmmss"
        return df.string(from: value as Date)
    }
    
    func dayFromDate(_ value: String) -> String? {
        let calendar = Calendar(identifier: .gregorian)
        let date = stringToDate(value)
        let wd = calendar.dateComponents([.weekday], from: date)
        if let wd = wd.weekday {
            return day[wd-1]
        }
        return nil
    }
    
    func displayDuringTime(startTime: String, endTime: String) -> String {
        
        let startDate = stringToDate(startTime)
        let endDate = stringToDate(endTime)
        
        let strDisplay = String(format: "%02d:%02d ~ %02d:%02d", startDate.hour, startDate.minute, endDate.hour, endDate.minute)
        
        return strDisplay
    }
    
    func isAvailableTime(endTime: String) -> Bool {
        let endDate = stringToDate(endTime)
        
        let nowDate = Date()
        
        if nowDate > endDate {
            return false
        } else {
            return true
        }
    }
    
    func calcleftTime(startTime: String, endTime: String) -> String? {
        
        let startDate = stringToDate(startTime)
        let endDate = stringToDate(endTime)
        
        let nowDate = Date()
        
        if nowDate > startDate && endDate > nowDate {
//            let dateGap = endDate.minute - nowDate.minute
            let interval = endDate-nowDate
            
            return String(format: "%02.0f", interval/60)
//            return "\(interval/60)"
        } else {
            return nil
        }
    }
    
    
    func arrangeImpossibleTime(arrTime: Array<String>?) -> Array<Array<String>>? {
        
        guard let arrImpossible = arrTime else {
            return nil
        }
        
        print(arrImpossible)
        
        var arrArrangeImpossible: [[String]]?
        
        arrArrangeImpossible = [[String]]()
        
        var arrValue: [String]?
        
        for (index, value) in arrImpossible.enumerated() {
            print("\(index): \(value)")
            
            if (index % 2 == 0) {
                arrValue = [String]()
                arrValue?.append(value)
            } else {
                arrValue?.append(value)
                arrArrangeImpossible?.append(arrValue!)
            }
        }
        
        print(arrArrangeImpossible!)
        
        return arrArrangeImpossible
    }
    
    
    func isImpossibleTime(arrImpossibleTime: [[String]], startDay: Date, endDay: Date) -> Bool {
        
        for item in arrImpossibleTime {
            
            if let strImpSTime = item.first, let strImpETime = item.last {
                let impSTime = stringToDate(strImpSTime)
                let impETime = stringToDate(strImpETime)
                
                let bStartDayEnable = startDay.isBetween(date: impSTime, and: impETime)
                let bEndDayEnable = endDay.isBetween(date: impSTime, and: impETime)
                
                let bStartEnable = impSTime.isBetween(date: startDay, and: endDay)
                let bEndEnable = impETime.isBetween(date: startDay, and: endDay)
                
                if bStartDayEnable == true {
                    print("calcImpossibleTime return false: \(impSTime) ~ \(impETime) : \(startDay)")
                    return true
                }
                
                if bEndDayEnable == true {
                    print("calcImpossibleTime return false: \(impSTime) ~ \(impETime) : \(startDay)")
                    return true
                }
                
                if bStartEnable == true {
                    print("calcImpossibleTime return false: \(impSTime) ~ \(impETime) : \(startDay)")
                    return true
                }
                
                if bEndEnable == true {
                    print("calcImpossibleTime return false: \(impSTime) ~ \(impETime) : \(endDay)")
                    return true
                }
            }
        }
        
        return false
    }
    
    
    
    func isBetweenOperationTime(dicPlace: Dictionary<String, Any>) -> Bool {
        
        var bStartEnable: Bool = false
        var bEndEnable: Bool = false
        
        var strWeek: String = ""
        var strEndWeek: String = ""
        let startDate = stringToDate(startTime!)
        let endDate = stringToDate(endTime!)
        
        print("##Today is \(endDate.weekdayName)  \(endDate)")
        print("##Start is \(dateToString(startDate))")
        print("##End is \(dateToString(endDate))")
        
        if startDate.isInWeekend {
            strWeek = "operationtime_holiday"
        } else {
            strWeek = "operationtime_week"
        }
        
        if endDate.isInWeekend {
            strEndWeek = "operationtime_holiday"
        } else {
            strEndWeek = "operationtime_week"
        }
        
        
        /*
         if let strOperationTime = dicPlace[strWeek] as? String {
         print("##Operation Time is \(strOperationTime)")
         } else {
         return false
         }
         */
        
        guard let strOperation = dicPlace[strWeek] as? String else {
            return false
        }
        
        var arrStr = strOperation.split(separator: "~").map { (strTime) -> String in
            return String(strTime)
        }
        
        print(arrStr)
        
        
        if arrStr.count < 2 {
            arrStr.removeAll()
            
            arrStr = strOperation.split(separator: "-").map { String($0)}
        }
        
        
        if arrStr.count < 2 {
            return false
        }
        
        
        if let strStart = arrStr.first, let strEnd = arrStr.last {
            print(strStart)
            print(strEnd)
            
            
//            let arrFirst
            
            
            
            let arrSTime = strStart.split(separator: ":").map { String($0)}
            let arrETime = strEnd.split(separator: ":").map { String($0)}
            
            var fOpStartHour: Int
            let fOpStartMin: Int
            
            var fOpEndHour: Int
            let fOpEndMin: Int
            
            if arrSTime.count < 2 && arrETime.count < 2 {
                fOpStartHour = Int(strStart[0..<2])!
                fOpStartMin = Int(strStart[2..<strStart.count])!
                
                fOpEndHour = Int(strEnd[0..<2])!
                fOpEndMin = Int(strEnd[2..<strEnd.count])!
            } else {
                fOpStartHour = Int(arrSTime.first!)!
                fOpStartMin = Int(arrSTime.last!)!
                
                fOpEndHour = Int(arrETime.first!)!
                fOpEndMin = Int(arrETime.last!)!
                
            }
            
            /*
            let fOpStartHour = Int(strStart[0..<2])!
            let fOpStartMin = Int(strStart[2..<strStart.count])!
            
            var fOpEndHour = Int(strEnd[0..<2])!
            let fOpEndMin = Int(strEnd[2..<strEnd.count])!
             */
            
            if fOpEndHour == 00 {
                fOpEndHour = 24
            }
            
            
            
            
            
            let calendar = Calendar.current
            let sDate = calendar.date(from: calendar.dateComponents(in: TimeZone.current, from: startDate))
            print(sDate)
            print("##OriginalSDate is \(dateToString(sDate!))\n")
            
            
            var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: sDate!)
            components.hour = fOpStartHour
            components.minute = fOpStartMin
            
            let opStartDate = calendar.date(from: components)
            
            
            let eDate = calendar.date(from: calendar.dateComponents(in: TimeZone.current, from: startDate))
            print(eDate)
            var eComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: eDate!)
            
            
            eComponents.hour = fOpEndHour
            eComponents.minute = fOpEndMin
            
            if (fOpStartHour > fOpEndHour) {
//                eComponents.day = eComponents.day! + 1
            }
            
            
            var opEndDate = calendar.date(from: eComponents)
            
            
            if (fOpStartHour > fOpEndHour) {
                opEndDate = opEndDate! + 24.hour
            }
            
            print(opStartDate)
            print("##trans opStartDate is \(dateToString(opStartDate!))\n")
            print(opEndDate)
            print("##trans opEndDate is \(dateToString(opEndDate!))\n")
            
            let opAvailStartDate = opStartDate! - 1.seconds
            print("##Avail StartDate is \(opAvailStartDate)")
            print("##Avail StartDate is \(dateToString(opAvailStartDate))\n")
            
            let opAvailEndDate = opEndDate! + 1.seconds
            print("##Avail EndDate is \(opAvailEndDate)")
            print("##Avail EndDate is \(dateToString(opAvailEndDate))\n")
            
            bStartEnable = startDate.isBetween(date: opAvailStartDate, and: opAvailEndDate)
            bEndEnable = endDate.isBetween(date: opAvailStartDate, and: opAvailEndDate)
            
            print("##StartEnable is \(bStartEnable)")
            print("##EndEnable is \(bEndEnable)\n")
            print("##Result is \(bStartEnable && bEndEnable)\n")
            
            
            
            if startDate.day != endDate.day && bEndEnable == false {
                guard let strOperation = dicPlace[strEndWeek] as? String else {
                    return false
                }
                
                var arrStr = strOperation.split(separator: "~").map { (strTime) -> String in
                    return String(strTime)
                }
                
                print(arrStr)
                
                
                if arrStr.count < 2 {
                    arrStr.removeAll()
                    
                    arrStr = strOperation.split(separator: "-").map { String($0)}
                }
                
                
                
                if let strStart = arrStr.first, let strEnd = arrStr.last {
                    print(strStart)
                    print(strEnd)
                    
                    
                    //            let arrFirst
                    
                    
                    
                    let arrSTime = strStart.split(separator: ":").map { String($0)}
                    let arrETime = strEnd.split(separator: ":").map { String($0)}
                    
                    var fOpStartHour: Int
                    let fOpStartMin: Int
                    
                    var fOpEndHour: Int
                    let fOpEndMin: Int
                    
                    if arrSTime.count < 2 && arrETime.count < 2 {
                        fOpStartHour = Int(strStart[0..<2])!
                        fOpStartMin = Int(strStart[2..<strStart.count])!
                        
                        fOpEndHour = Int(strEnd[0..<2])!
                        fOpEndMin = Int(strEnd[2..<strEnd.count])!
                    } else {
                        fOpStartHour = Int(arrSTime.first!)!
                        fOpStartMin = Int(arrSTime.last!)!
                        
                        fOpEndHour = Int(arrETime.first!)!
                        fOpEndMin = Int(arrETime.last!)!
                        
                    }
                    
                    /*
                     let fOpStartHour = Int(strStart[0..<2])!
                     let fOpStartMin = Int(strStart[2..<strStart.count])!
                     
                     var fOpEndHour = Int(strEnd[0..<2])!
                     let fOpEndMin = Int(strEnd[2..<strEnd.count])!
                     */
                    
                    if fOpEndHour == 00 {
                        fOpEndHour = 24
                    }
                    
                    
                    
                    
                    
                    let calendar = Calendar.current
                    let sDate = calendar.date(from: calendar.dateComponents(in: TimeZone.current, from: endDate))
                    print(sDate)
                    print("##OriginalSDate is \(dateToString(sDate!))\n")
                    
                    
                    var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: sDate!)
                    components.hour = fOpStartHour
                    components.minute = fOpStartMin
                    
                    let opStartDate = calendar.date(from: components)
                    
                    
                    let eDate = calendar.date(from: calendar.dateComponents(in: TimeZone.current, from: endDate))
                    print(eDate)
                    var eComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: eDate!)
                    
                    
                    eComponents.hour = fOpEndHour
                    eComponents.minute = fOpEndMin
                    
                    if (fOpStartHour > fOpEndHour) {
                        //                eComponents.day = eComponents.day! + 1
                    }
                    
                    
                    var opEndDate = calendar.date(from: eComponents)
                    
                    
                    if (fOpStartHour > fOpEndHour) {
                        opEndDate = opEndDate! + 24.hour
                    }
                    
                    print(opStartDate)
                    print("##trans opStartDate is \(dateToString(opStartDate!))\n")
                    print(opEndDate)
                    print("##trans opEndDate is \(dateToString(opEndDate!))\n")
                    
                    let opAvailStartDate = opStartDate! - 1.seconds
                    print("##Avail StartDate is \(opAvailStartDate)")
                    print("##Avail StartDate is \(dateToString(opAvailStartDate))\n")
                    
                    let opAvailEndDate = opEndDate! + 1.seconds
                    print("##Avail EndDate is \(opAvailEndDate)")
                    print("##Avail EndDate is \(dateToString(opAvailEndDate))\n")
                    
//                    bStartEnable = startDate.isBetween(date: opAvailStartDate, and: opAvailEndDate)
                    bEndEnable = endDate.isBetween(date: opAvailStartDate, and: opAvailEndDate)
                    
                    if opAvailStartDate.hour != 0 {
                        bEndEnable = false
                    }
                    
                    print("##StartEnable is \(bStartEnable)")
                    print("##EndEnable is \(bEndEnable)\n")
                    print("##Result is \(bStartEnable && bEndEnable)\n")
                }
                
            }
            
            
            return bStartEnable && bEndEnable
            
        }
        
        return false
    }
    
    
}
