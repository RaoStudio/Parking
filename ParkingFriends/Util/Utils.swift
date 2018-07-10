//
//  Utils.swift
//  MyMemory
//
//  Created by MyoungHyoun Cho on 2018. 3. 21..
//  Copyright © 2018년 rao. All rights reserved.
//

import Foundation
import Security
import Alamofire

// Raduis
enum RadiusType: String {
    case fiveH = "500m"
    case oneT = "1Km"
    case fiveT = "5Km"
    case tenT = "10km"
    
    static let allValues = [fiveH, oneT, fiveT, tenT]
}

enum RadiusValue: Int {
    case fiveH = 500
    case oneT = 1000
    case fiveT = 5000
    case tenT = 10000
    
    static let allValues = [fiveH, oneT, fiveT, tenT]
}


// UserAlarmTime
enum UserAlarmType: String {
    case none = "알람 안함"
    case appoint = "정각"
    case one = "1분 전"
    case three = "3분 전"
    case five = "5분 전"
    case ten = "10분 전"
    case fifteen = "15분 전"
    case twenty = "20분 전"
    case thirty = "30분 전"
    case hour = "1시간 전"
}

enum UserAlarmValue: Int {
    case none = -1
    case appoint = 0
    case one = 60
    case three = 180
    case five = 300
    case ten = 600
    case fifteen = 900
    case twenty = 1200
    case thirty = 1800
    case hour = 3600
}



struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
}

@available(iOS 11.0, *)
struct RaoIPhoneX {
    static let isIPhoneX: Bool = {
        
            var isX = false
            if ((UIApplication.shared.keyWindow?.safeAreaInsets.top)! > CGFloat(0.0)) {
                isX = true
            }
            return isX
        }()
}

/*
- (BOOL)isIphoneX {
    if (@available(iOS 11.0, *)) {
        UIWindow *window = UIApplication.sharedApplication.keyWindow;
        CGFloat topPadding = window.safeAreaInsets.top;
        if(topPadding>0) {
            return YES;
        }
        else {
            return NO;
        }
    }
    else {
        return NO;
    }
}
*/


func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

extension UIAlertAction {
    func setTextColor(_ color: UIColor) {
//        self.setValue(color, forKey: "titleTextColor")
    }
}


extension UIViewController {
    var tutorialSB : UIStoryboard {
        return UIStoryboard(name: "Tutorial", bundle: Bundle.main)
    }
    
    func instanceTutorialVC(name: String) -> UIViewController? {
        return self.tutorialSB.instantiateViewController(withIdentifier:name)
    }
    
    func alert(_ message: String, completion: (()->Void)? = nil) {
        // Execute in Main Thread
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: { (_) in
                completion?()
            })
            alert.addAction(okAction)
            self.present(alert, animated: false, completion: nil)
        }
    }
}

extension UIViewController {
    
    func startLoading(){
        
        print("START LOADING")
        (UIApplication.shared.delegate as! AppDelegate).startLoading()
        
    }
    
    func endLoading(){
        
        print("END LOADING")
        (UIApplication.shared.delegate as! AppDelegate).endLoading()
        
    }
    
    func showToast(toastTitle: String?, toastMsg: String, interval: Double) {
        
        // show message
        let message = UIAlertController(title: toastTitle, message: toastMsg, preferredStyle: UIAlertControllerStyle.alert)
        self.present(message, animated: true, completion: {})
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(dismissToastMessage(sender:)), userInfo: nil, repeats: true)
        
    }
    
    @objc func dismissToastMessage(sender: AnyObject?) {
        var timer = sender as? Timer
        self.dismiss(animated: true, completion: {
            timer?.invalidate()
            timer = nil
        })
    }
    
    
    func showAlert(toastTitle: String, toastMsg: String, positiveBtn: Bool, negativeBtn: Bool ,  done_action: @escaping () -> Void , cancel_action: @escaping () -> Void) {
        // dismiss any popup
        
        // alert을 하나만 띄울 수 있기 때문에 보여지고 있는 것이 있다면 다 닫는다.
        // Material 의 툴바등의 UIView확장 클래스는 모두 중첩뷰이므로, 올라온 얼럿을 닫기위해서는 tag처럼 구분자 추가 필요
        // self.dismiss(animated: true, completion: nil)
        
        let message = UIAlertController(title: toastTitle, message: toastMsg, preferredStyle: UIAlertControllerStyle.alert)
        
        // 확인 버튼
        if positiveBtn {
            message.addAction(
                UIAlertAction(title: "확인", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                    done_action()
                }
            )
        }
        
        // 취소 버튼
        if negativeBtn {
            message.addAction(
                UIAlertAction(title: "취소", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                    cancel_action()
                }
            )
        }
        
        // show message
        self.present(message, animated: true, completion: {})
    }
    
    // 확인 버튼 클릭시 호출
    func onClickedPositiveButton() {
        print("onClicked Positive Button")
    }
    
    // 취소 버튼 클릭시 호출
    func onClickedNegativeButton() {
        print("onClicked Negative Button")
    }
    
}

extension UIScrollView {
    func scrollToBottom(animated: Bool) {
        if self.contentSize.height < self.bounds.size.height { return }
        let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
        self.setContentOffset(bottomOffset, animated: animated)
    }
}

extension UIView {
    
    func dictionaryOfNames(arr:UIView...) -> Dictionary<String,UIView> {
        var d = Dictionary<String,UIView>()
        for (ix,v) in arr.enumerated(){
            d["v\(ix+1)"] = v
        }
        return d
    }
    
    func addConstraintForFullsizeWithSubView(subview: UIView) {
        /* Obj-C
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subview]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(subview)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subview]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(subview)]];
        */
        
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v1]|", options: [], metrics: nil, views: dictionaryOfNames(arr: subview)))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v1]|", options: [], metrics: nil, views: dictionaryOfNames(arr: subview)))
//        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subview]|", options: [], metrics: nil, views: ["subview": subview as UIView]))
//        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subview]|", options: [], metrics: nil, views: ["subview": subview as UIView]))
        
        
    }
}

class TokenUtils {
    
    var AuthorizationHeader : HTTPHeaders? {
        get {
            guard let serviceID = Bundle.main.bundleIdentifier else {
                print("Bundel ID is nil")
                return nil
            }
            
            if let accessToken = self.load(serviceID, account: "accessToken") {
                return ["Authorization":"Bearer \(accessToken)"] as HTTPHeaders
            } else {
                return nil
            }
        }
    }
    
    func getBundleIdentifier() -> String {
        guard let servicdeID = Bundle.main.bundleIdentifier else {
            return "kr.co.rubypaper.MyMemory"
        }
        
        return servicdeID
    }
    
    func getAuthorizationHeader() -> HTTPHeaders? {
        guard let serviceID = Bundle.main.bundleIdentifier else {
            print("Bundel ID is nil")
            return nil
        }
        
        if let accessToken = self.load(serviceID, account: "accessToken") {
            return ["Authorization":"Bearer \(accessToken)"] as HTTPHeaders
        } else {
            return nil
        }
    }
    
    func load(_ service: String, account: String) -> String? {
        let keyChainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService : service,
            kSecAttrAccount : account,
            kSecReturnData : kCFBooleanTrue,
            kSecMatchLimit : kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(keyChainQuery, &dataTypeRef)
        
        if ( errSecSuccess == status ) {
            let retrievedData = dataTypeRef as! Data
            let value = String(data: retrievedData, encoding: String.Encoding.utf8)
            return value
        } else {
            print("Nothing was retrieved from the keychain. Status code \(status)")
            return nil
        }
    }
    
    func save(_ service: String, account: String, value: String) {
        let keyChainQuery: NSDictionary = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrService : service,
            kSecAttrAccount : account,
            kSecValueData : value.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        ]
        
        SecItemDelete(keyChainQuery)
        
        let status: OSStatus = SecItemAdd(keyChainQuery, nil)
        assert(status == noErr, "Fail to save TokenValue")
        NSLog("statue=\(status)")
    }
    
    func delete(_ service: String, accout: String) {
        let keyChainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword
        ]
        
        let status = SecItemDelete(keyChainQuery)
        assert(status == noErr, "Fail to delete tokenValue")
        NSLog("status=\(status)")
    }
    
}
