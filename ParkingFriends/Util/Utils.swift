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

struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
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
