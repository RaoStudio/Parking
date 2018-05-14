//
//  UserInfoManager.swift
//  ParkingFriends
//
//  Created by MyoungHyoun Cho on 2018. 5. 14..
//  Copyright © 2018년 rao. All rights reserved.
//

import Foundation

struct UserInfoKey {
    static let radius = "RADIUS"
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
}
