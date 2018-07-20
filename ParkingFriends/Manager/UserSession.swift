//
//  UserSession.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 6. 20..
//  Copyright © 2018년 rao. All rights reserved.
//

import Foundation


struct UserSessionKey {
    static let sid = "SID"
    static let name = "NAME"
    static let email = "EMAIL"
    static let provider = "PROVIDER"
    static let authId = "AUTHID"
    static let mobile = "MOBILE"
    static let photoUrl = "PHOTHURL"
    static let carName = "CARNAME"
    static let carNum = "CARNUM"
    static let parkOwned = "PARKOWNED"
    static let point = "POINT"                  // Int
    static let cardNum = "CARDNUM"
    static let cardExpire = "CARDEXPIRE"
    static let isLogin = "ISLOGIN"              // Bool
    static let isMonthlyPark = "ISMONTHLYPARK"  // Bool
    static let isPaying = "ISPAYING"            // Bool
}


class UserSession {
    
    var sid: String? {
        get {
            return UserDefaults.standard.string(forKey: UserSessionKey.sid)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserSessionKey.sid)
            ud.synchronize()
        }
    }
    
    var name: String? {
        get {
            return UserDefaults.standard.string(forKey: UserSessionKey.name)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserSessionKey.name)
            ud.synchronize()
        }
    }
    
    var email: String? {
        get {
            return UserDefaults.standard.string(forKey: UserSessionKey.email)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserSessionKey.email)
            ud.synchronize()
        }
    }
    
    var provider: String? {
        get {
            return UserDefaults.standard.string(forKey: UserSessionKey.provider)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserSessionKey.provider)
            ud.synchronize()
        }
    }
    
    var authId: String? {
        get {
            return UserDefaults.standard.string(forKey: UserSessionKey.authId)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserSessionKey.authId)
            ud.synchronize()
        }
    }
    
    var mobile: String? {
        get {
            return UserDefaults.standard.string(forKey: UserSessionKey.mobile)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserSessionKey.mobile)
            ud.synchronize()
        }
    }
    
    var photoUrl: String? {
        get {
            return UserDefaults.standard.string(forKey: UserSessionKey.photoUrl)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserSessionKey.photoUrl)
            ud.synchronize()
        }
    }
    
    var carName: String? {
        get {
            return UserDefaults.standard.string(forKey: UserSessionKey.carName)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserSessionKey.carName)
            ud.synchronize()
        }
    }
    
    var carNum: String? {
        get {
            return UserDefaults.standard.string(forKey: UserSessionKey.carNum)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserSessionKey.carNum)
            ud.synchronize()
        }
    }
    
    var parkOwned: String? {
        get {
            return UserDefaults.standard.string(forKey: UserSessionKey.parkOwned)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserSessionKey.parkOwned)
            ud.synchronize()
        }
    }
    
    var point: Int? {
        get {
            return UserDefaults.standard.integer(forKey: UserSessionKey.point)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserSessionKey.point)
            ud.synchronize()
        }
    }
    
    var cardNum: String? {
        get {
            return UserDefaults.standard.string(forKey: UserSessionKey.cardNum)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserSessionKey.cardNum)
            ud.synchronize()
        }
    }
    
    var cardExpire: String? {
        get {
            return UserDefaults.standard.string(forKey: UserSessionKey.cardExpire)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserSessionKey.cardExpire)
            ud.synchronize()
        }
    }
    
    var isLogin: Bool? {
        get {
            return UserDefaults.standard.bool(forKey: UserSessionKey.isLogin)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserSessionKey.isLogin)
            ud.synchronize()
        }
    }
    
    var isMonthlyPark: Bool? {
        get {
            return UserDefaults.standard.bool(forKey: UserSessionKey.isMonthlyPark)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserSessionKey.isMonthlyPark)
            ud.synchronize()
        }
    }
    
    var isPaying: Bool? {
        get {
            return UserDefaults.standard.bool(forKey: UserSessionKey.isPaying)
        }
        
        set(v) {
            let ud = UserDefaults.standard
            ud.setValue(v, forKey: UserSessionKey.isPaying)
            ud.synchronize()
        }
    }
}

extension UserSession {
    
    func initUserSession() {
        sid = ""
        name = ""
        email = ""
        provider = ""
        authId = ""
        mobile = ""
        photoUrl = ""
        carName = ""
        carNum = ""
        parkOwned = ""
        point = -1
        cardNum = ""
        cardExpire = ""
        isLogin = false
        isMonthlyPark = false
        isPaying = false
        
    }
    
    func getCarInfo() -> String {
        if let strCarName = self.carName, let strCarNum = self.carNum, !strCarName.isEmpty, !strCarNum.isEmpty {
            return "\(strCarName) (\(strCarNum))"
        } else {
            return "(차량 없음)"
        }
        
    }
    
    /*
    public void clear() {
    this.mSID = null;
    this.mName = null;
    this.mEmail = null;
    this.mProvider = null;
    this.mAuthId = null;
    this.mMobile = null;
    this.mPhotoUrl = null;
    this.mCarName = null;
    this.mCarNum = null;
    this.mParkOwned = null;
    this.mPoint = -1;
    this.mCardNum = null;
    this.mCardExpire = null;
    setLogin(false);
    }
     */
}
