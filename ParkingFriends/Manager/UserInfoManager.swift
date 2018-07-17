//
//  UserInfoManager.swift
//  ParkingFriends
//
//  Created by MyoungHyoun Cho on 2018. 5. 14..
//  Copyright © 2018년 rao. All rights reserved.
//

import Foundation
import SwiftDate

struct UserInfoKey {
    static let tutorial = "TUTORIAL"
    static let radius = "RADIUS"
    static let startTime = "STARTTIME"
    static let endTime = "ENDTIME"
    static let isUserAlarm = "ISUSERALARM"
    
    static let rLatitude = "RESERVE_LATITUDE"
    static let rLongtitude = "RESERVE_LONGITUDE"
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
}

extension UserInfoManager {

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
    
    func dayFromDate(_ value: String) -> String? {
        let calendar = Calendar(identifier: .gregorian)
        let date = stringToDate(value)
        let wd = calendar.dateComponents([.weekday], from: date)
        if let wd = wd.weekday {
            return day[wd-1]
        }
        return nil
    }
}
