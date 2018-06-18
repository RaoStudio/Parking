//
//  LoginVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 6. 12..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import CoreData


class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Login"
        
        
 /*
        self.navigationController?.navigationBar.isHidden = true
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapMyView(_:)))
        self.view.addGestureRecognizer(tap)
        self.navigationController?.navigationBar.isTranslucent = true
 */
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
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
                print(error?.localizedDescription ?? "")
            } else if session.isOpen() {
                KOSessionTask.meTask(completionHandler: {(profile, error) -> Void in
                    
                    if profile != nil {
                        DispatchQueue.main.async(execute: { () -> Void in
                            
                            
                            let kakao : KOUser = profile as! KOUser
                            
                            if let value = kakao.properties?["nickname"] as? String{
                             
                                self.alert(value)
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
