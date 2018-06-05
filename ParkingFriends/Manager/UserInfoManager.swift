//
//  UserInfoManager.swift
//  ParkingFriends
//
//  Created by MyoungHyoun Cho on 2018. 5. 14..
//  Copyright © 2018년 rao. All rights reserved.
//

import Foundation

struct UserInfoKey {
    static let tutorial = "TUTORIAL"
    static let radius = "RADIUS"
    static let startTime = "STARTTIME"
    static let endTime = "ENDTIME"
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
}

extension UserInfoManager {
    
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
