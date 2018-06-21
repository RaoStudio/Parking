//
//  LoginVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 6. 12..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import CoreData

import Firebase
import GoogleSignIn
import FBSDKLoginKit

import Alamofire
import SwiftyJSON
import Toast_Swift

class LoginVC: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate, FBSDKLoginButtonDelegate {
    
    
    @IBOutlet weak var btnGoogleLogin: GIDSignInButton!
    @IBOutlet weak var btnFacebookLogin: UIButton!
    
    let uSession = UserSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Login"
        
        
 //*
        self.navigationController?.navigationBar.isHidden = true
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapMyView(_:)))
        self.view.addGestureRecognizer(tap)
        self.navigationController?.navigationBar.isTranslucent = true
 //*/
        
        
//        self.btnFacebookLogin.delegate = self
//        btnFacebookLogin.readPermissions = ["public_profile", "email"]
        
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
//        self.navigationController?.navigationBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func tapMyView(_ sender : UIView) {
        
        if let bHidden = self.navigationController?.navigationBar.isHidden {
            if bHidden {
                self.navigationController?.navigationBar.isHidden = false
            } else {
                self.navigationController?.navigationBar.isHidden = true
            }
        }
    }
    
    // MARK: - Request to Parking Server ( SNS value -> Parking Server )
    
    func requestUserLogin(email: String, provider: String, authid: String) {
        let url = UrlStrings.URL_API_USER_LOGIN
//        let url = UrlStrings.URL_API_USER_SIGNUP
        
        let param = ["email": email,
                     "provider": provider,
                     "auth_id": authid] as [String: Any]
        
        Alamofire.request(url, method: HTTPMethod.post, parameters: param, encoding: URLEncoding.httpBody, headers: nil).responseString { (response) in
         
            guard response.result.isSuccess else {
                
                self.alert("\(url) : \(String(describing: response.result.error))")
                return
            }
            
            if let value = response.result.value as NSString? {
                
                if value.isEqual(to: "Not Found") {     // First Login (go to SMS Auth)
                  
                    return
                }
                
                if value.isEqual(to: "Auth Id Mismatch") || value.isEqual(to: "Provider Mismatch") {
                
                    self.alert("requestUserLogin = \(value)")
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
//                                self.showToast(toastTitle: nil, toastMsg: strComment, interval: 1)
                                
                                
                                
                                self.navigationController?.view.makeToast(strComment, duration: 2.0, position: .bottom, title: nil, image: nil) { didTap in
                                    if didTap {
                                        print("completion from tap")
                                    } else {
                                        print("completion without tap")
                                    }
                                }
                                
                                self.navigationController?.popViewController(animated: true)
                                
                                /*
                                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
                                    self.navigationController?.popViewController(animated: true)
                                }
                                */

                            }
                            
                        }
                                                                                                                        
                    } catch {
                        self.alert("requestUserLogin = \(value)")
                    }

                }
                
            }
        }
        
    }
    
    func requestUserRegister(provider: String, id: String, email: String, name: String, mobile: String, photoUrl: String) {
        let url = UrlStrings.URL_API_USER_SIGNUP
        
        
        let param = ["provider": provider,
                     "id": id,
                     "email": email,
                     "name": name,
                     "mobile": mobile,
                     "photo": photoUrl] as [String: Any]
        
        Alamofire.request(url, method: HTTPMethod.post, parameters: param, encoding: URLEncoding.httpBody, headers: nil).responseString { (response) in
            
        }
        
    }
    
    
    // MARK: - Action
    @IBAction func onBtnKakao(_ sender: UIButton) {
        let session :KOSession = KOSession.shared()
        
        if session.isOpen() {
            session.close()
        }
        
        session.presentingViewController = self
        
        session.open(completionHandler: {(error) -> Void in
            
            // 카카오 로그인 화면에서 벋어날 시 호출됨. (취소일 때도 표시됨)
            if error != nil
            {
                self.alert(error?.localizedDescription ?? "")
            }
            else if session.isOpen() {
                KOSessionTask.userMeTask(completion: {(error, profile) -> Void in
                    
                    if profile != nil {
                        DispatchQueue.main.async(execute: { () -> Void in
                            let kakao : KOUserMe = profile as! KOUserMe
                            
                            if let email = kakao.account?.email, let id = kakao.id, let nickName = kakao.properties?["nickname"], let thumbImgPath = kakao.properties?["thumbnail_image"]{
                            
                                self.uSession.initUserSession()
                                self.uSession.provider = "kakao"
                                self.uSession.authId = id
                                self.uSession.email = email
                                self.uSession.name = nickName
                                self.uSession.photoUrl = thumbImgPath
                                
                                self.requestUserLogin(email: email, provider: "kakao", authid: id)
                            }
                            
                            
                            
//                            let kakao : KOUser = profile as! KOUser
                            //String(kakao.ID)
                            
                            /*
                            guard (self.getAppDelegate()) != nil else{
                                return
                            }
                            
                            //Google DB Update
                            var info = UserInfo()
                            info.joinAddress = "kakao"
                            
                            if let value = kakao.properties?["nickname"] as? String{
                                //                                print("kakao nickname : \(value)\r\n")
                                info.name = "\(value)"
                            }
                            
                            if let value = kakao.email{
                                print("kakao email : \(value)\r\n")
                                info.email =  "\(value)"
                                info.id = "\(value)"
                            }
                            
                            //                            if let value = kakao.properties?["profile_image"] as? String{
                            ////                              self.imageView.image = UIImage(data: NSData(contentsOfURL: NSURL(string: value)!)!
                            //                                print("kakao imageView.image : \(value)\r\n")
                            //                            }
                            
                            //                            if let value = kakao.properties?["thumbnail_image"] as? String{
                            ////                                self.image2View.image = UIImage(data: NSData(contentsOfURL: NSURL(string: value)!)!)
                            //                                 print("kakao image2View.image : \(value)\r\n")
                            //                            }
                            
                            let appDelegate = self.getAppDelegate()
                            appDelegate?.addUserProfile(uid: appDelegate?.getDatabaseRef().childByAutoId().key, userInfo: info)
                            self.gotoMainViewController(user: info)
                             */
                        })
                    }
                })
            } else {
                print("isNotOpen")
            }
        })
    }
    
    
    
    @IBAction func onBtnGoogle(_ sender: UIButton) {
    
//        FirebaseApp.configure()
//        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        
//        GIDSignIn.sharedInstance().clientID = "com.googleusercontent.apps.675515171374-k5bqb7s78ttsjp1tvp4ec9umiqeuumph"
//        GIDSignIn.sharedInstance().delegate = self
 
    
//        GIDSignIn.sharedInstance().signIn()
        
        GIDSignIn.sharedInstance().delegate = self
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    
    @IBAction func onBtnFacebook(_ sender: UIButton) {
        
        /*
        if let token = FBSDKAccessToken.current() {
            
        } else {
            self.facebookLogin()
        }
         */
        
        //*
        let loginButton = FBSDKLoginButton()
        loginButton.delegate = self
        
        loginButton.loginBehavior = FBSDKLoginBehavior.web
//        .facebookLoginManager().loginBehavior = FBSDKLoginBehavior.web
        
        loginButton.sendActions(for: UIControlEvents.touchUpInside)
        //*/
    }
    
    // MARK: - GIDSignInDelegate
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            // ...
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        // ...
        
        Auth.auth().signIn(with: credential) { (user, error) in
            // ...
            if let err = error {
                print("LoginViewController:    error = \(err)")
                return
            }
            
            // todo...
            // 넘어오는 값을 기준으로 회원가입을 진행하면 됩니다.
            print("name: \(user?.displayName)")
            print("email: \(user?.email)")
            
            self.alert("name: \(user?.displayName), email: \(user?.email)")
            
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    
    // MARK: - Facebook Login
    /*
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        // ...
    }
 */
    
    func facebookLogin() {
        let fbLoginManager: FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
            if error != nil {
                NSLog("Process Error")
            } else if result?.isCancelled == true {
                NSLog("Cancelled")
            } else {
                NSLog("Logged in")
            }
        }
    }
    
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        if result.isCancelled == true {
            NSLog("Cancelled")
            return
        }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        // ...
        
        Auth.auth().signIn(with: credential) { (user, error) in
            // ...
            if let err = error {
                print("LoginViewController:    error = \(err)")
                return
            }
            
            // todo...
            // 넘어오는 값을 기준으로 회원가입을 진행하면 됩니다.
            print("name: \(user?.displayName)")
            print("email: \(user?.email)")
            
            self.alert("name: \(user?.displayName), email: \(user?.email)")
            
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
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
