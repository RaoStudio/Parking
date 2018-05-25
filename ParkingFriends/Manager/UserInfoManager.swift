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
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return df.date(from: value)!
    }
    
    func dateToString(_ value: Date) -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return df.string(from: value as Date)
    }
}
