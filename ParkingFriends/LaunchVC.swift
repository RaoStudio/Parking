//
//  LaunchVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 6. 29..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift

class LaunchVC: UIViewController {

    var bStart: Bool = false
    
    var uSession = UserSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.isHidden = true
        
        
        
        /*
         guard let mainNavi = self.storyboard?.instantiateViewController(withIdentifier: "MainNavi") as? UINavigationController else {
         return
         }
         
         self.present(mainNavi, animated: true, completion: nil)
         */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /*
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
            self.navigationController?.navigationBar.isHidden = false
            
            self.willMove(toParentViewController: nil)
            self.removeFromParentViewController()
            self.view.removeFromSuperview()
            self.didMove(toParentViewController: nil)
            
        }
        */
        
        if uSession.isLogin == true {
            requestUserLogin(email: uSession.email!, provider: uSession.provider!, authid: uSession.authId!, completionHandler: removeSelf)
        } else {
            removeSelf()
        }
        
    }
    
    func removeSelf() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2000)) {
            self.navigationController?.navigationBar.isHidden = false
            
            
            self.navigationController?.view.hideToastActivity()
            
            self.willMove(toParentViewController: nil)
            self.removeFromParentViewController()
            self.view.removeFromSuperview()
            self.didMove(toParentViewController: nil)
            
        }
    }

    
    // MARK: - Request to Parking Server ( SNS value -> Parking Server )
    
    func requestUserLogin(email: String, provider: String, authid: String, completionHandler:@escaping ()->()) {
        
        /*
        var style = ToastStyle()
        style.activitySize = CGSize(width: 50.0, height: 50.0)
        ToastManager.shared.style = style
 */
        
        
        
        self.navigationController?.view.makeToastActivity(.downCenter)
        
        
//        self.navigationController?.view.makeToast("로그인이 필요합니다.", duration: 1.0, position: .bottom)
        
        
        let url = UrlStrings.URL_API_USER_LOGIN
        
        
        let param = ["email": email,
                     "provider": provider,
                     "auth_id": authid] as [String: Any]
        
        Alamofire.request(url, method: HTTPMethod.post, parameters: param, encoding: URLEncoding.httpBody, headers: nil).responseString { (response) in
            
//            self.navigationController?.view.hideToastActivity()
            
            guard response.result.isSuccess else {
//                self.alert("\(url) : \(String(describing: response.result.error))")
                self.navigationController?.view.makeToast("\(url) : \(String(describing: response.result.error))", duration: 2.0, position: .bottom)
                completionHandler()
                return
            }
            
            if let value = response.result.value as NSString? {
                
                if value.isEqual(to: "Not Found") || value.isEqual(to: "Auth Id Mismatch") || value.isEqual(to: "Provider Mismatch") || value.isEqual(to: "Post Error") {
                    
                    self.navigationController?.view.makeToast(value as String, duration: 2.0, position: .bottom)
                    completionHandler()
                    return
                }
                
                
                if let dataFromString = value.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false) {
                    do {
                        let json = try JSON(data: dataFromString)
                        
                        let dic = json[0]
                        
                        if let strProvider = self.uSession.provider, let strAuthId = self.uSession.authId {
                            
                            if strProvider == dic["provider"].stringValue && strAuthId == dic["auth_id"].stringValue {
                                
                                self.uSession.initUserSession()
                                self.uSession.sid = dic["sid"].stringValue
                                self.uSession.provider = dic["provider"].stringValue
                                self.uSession.authId = dic["auth_id"].stringValue
                                self.uSession.email = dic["email"].stringValue
                                self.uSession.name = dic["name"].stringValue
                                self.uSession.mobile = dic["mobile"].stringValue
                                self.uSession.photoUrl = dic["photo"].stringValue
                                self.uSession.point = Int(dic["point"].stringValue)
                                self.uSession.carName = dic["car_name"].stringValue
                                self.uSession.carNum = dic["car_num"].stringValue
                                self.uSession.isLogin = true
                                
                                let strComment = String(format: "%@님 환영합니다", dic["name"].stringValue)
                                
                                
                                
                                self.navigationController?.view.makeToast(strComment, duration: 2.0, position: .upBottom, title: nil, image: nil) { didTap in
//                                self.navigationController?.view.makeToast(strComment, duration: 2.0, point: CGPoint(x: 110.0, y: 110.0), title: nil, image: nil) { didTap in
                                    if didTap {
                                        print("completion from tap")
                                    } else {
                                        print("completion without tap")
                                    }
                                }
                                
                                completionHandler()
                                
                            }
                            
                        }
                        
                    } catch {
//                        self.alert("requestUserLogin = \(value)")
                        self.navigationController?.view.makeToast("자동 로그인 실패", duration: 2.0, position: .bottom)
                        completionHandler()
                    }
                    
                }
                
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
