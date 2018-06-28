//
//  RegisterVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 6. 22..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift

class RegisterVC: UIViewController {

    
    @IBOutlet weak var constInputView: NSLayoutConstraint!      // Orig ( 200 )
    @IBOutlet weak var constCompleteView: NSLayoutConstraint!   // Orig ( 90 )
    @IBOutlet weak var stackComplete: UIStackView!
    
    
    
    @IBOutlet weak var txtPhoneNum: UITextField!
    @IBOutlet weak var txtAuthNum: UITextField!
    
    
    @IBOutlet weak var btnSMS: UIButton!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var btnRegisterComplete: UIButton!
    
    
    @IBOutlet weak var lbl_Tel: UILabel!
    @IBOutlet weak var lbl_Time: UILabel!
    var countDown = 300
    var timer: Timer?
    
    
    @IBOutlet weak var btnPF: UIButton!
    @IBOutlet weak var btnPersonal: UIButton!
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var btnAll: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.constCompleteView.constant = 0.0
        stackComplete.isHidden = true
        
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapMyView(_:)))
        self.view.addGestureRecognizer(tap)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @objc func tapMyView(_ sender : UIView) {
        txtPhoneNum.resignFirstResponder()
        txtAuthNum.resignFirstResponder()
    }
    
    
    // MARK: - Timer
    func countDown(time: Double) {
        self.timer = Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(updateCountDown), userInfo: nil, repeats: true)
    }
    
    @objc func updateCountDown() {
        if(countDown > 0) {
            let minutes = String(countDown / 60)
            let seconds = String(format: "%02d", countDown % 60)
            
            lbl_Time.text = minutes + ":" + seconds
            
            countDown = countDown - 1
        } else {
            removeCountDown()
        }
    }
    
    private func removeCountDown() {
        countDown = 300
        lbl_Time.text = "5:00"
        
        timer?.invalidate()
        timer = nil
    }
    
    
    
    // MARK: - PF API Call
    func requestSMSSend(phone: String) {
        
        self.navigationController?.view.makeToastActivity(.center)
        
        let url = UrlStrings.URL_API_SMS
        
        let param = ["phone": phone]
        
        Alamofire.request(url, method: HTTPMethod.post, parameters: param, encoding: URLEncoding.httpBody, headers: nil).responseString { (response) in
            
            
            self.navigationController?.view.hideToastActivity()
            
            
            guard response.result.isSuccess else {
                self.alert("\(url) : \(String(describing: response.result.error))")
                return
            }
            
            
            
            if let value = response.result.value as NSString? {
            
            
                /*
                let dict: [String: Int] = [:]
                
                let arrStr = value.split(separator: ":")
                
                
                
                let jsonText = "{\"first_name\":\"Sergey\"}"
                var dictonary:NSDictionary?
                
                if let data = value.data(using: String.Encoding.utf8) {
                    
                    do {
                        dictonary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] as! NSDictionary
                        
                        if let myDictionary = dictonary
                        {
                            print(" First name is: \(myDictionary["first_name"]!)")
                        }
                    } catch let error as NSError {
                        print(error)
                    }
                }
                */
     
                
                
                /*
                if let data = response.result.value?.data(using: String.Encoding.utf8) {
                    do {
                        let json = JSON(parseJSON: response.result.value!)
                        print(json)
                    } catch {
                        self.alert("requestUserLogin = \(value)")
                    }
                }
                */
                
                /*
                if let data = value.data(using: String.Encoding.utf8.rawValue) {
                    do {
                        let json = try? JSON(data: data)
                        print(json)
                    } catch {
                        self.alert("requestUserLogin = \(value)")
                    }
                }
                */
                
                //*
                if let dataFromString = value.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false) {
                
                    
                    do {
                        let json = try JSON(data: dataFromString)
                        print(json)
                        
                        let dic = json
                        
                        let strStatus = dic["status"].stringValue
                        
                        if strStatus == "200" {
//                            self.navigationController?.view.makeToast("인증번호를 발송하였습니다.", duration: 2.0, position: .bottom)
                            self.showToast(toastTitle: nil, toastMsg: "인증번호를 발송하였습니다. 인증번호를 입력해주세요." as String, interval: 2.0)
                            
                            self.removeCountDown()
                            self.countDown(time: 1.0)
                            
                            
                        } else {
                            self.navigationController?.view.makeToast("잠시후 다시 요청해주세요.", duration: 2.0, position: .bottom)
                        }
                        
                    } catch {
                        self.alert("requestSMSSend = \(value)")
                    }
                    
                }
                //*/
                
            }
            
        }
        
        
    }
    
    
    func requestSMSConfirm(phone: String, code: String) {
        self.navigationController?.view.makeToastActivity(.center)
        
        let url = UrlStrings.URL_API_SMSCONFIRM
        
        let param = ["phone": phone, "code": code]
        
        Alamofire.request(url, method: HTTPMethod.post, parameters: param, encoding: URLEncoding.httpBody, headers: nil).responseString { (response) in
            
            
            self.navigationController?.view.hideToastActivity()
            
            guard response.result.isSuccess else {
                self.alert("\(url) : \(String(describing: response.result.error))")
                return
            }
            
            if let value = response.result.value as NSString? {
                
                if let dataFromString = value.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false) {
                    
                    do {
                        let json = try JSON(data: dataFromString)
                        print(json)
                        
                        let dic = json
                        
                        let strStatus = dic["status"].stringValue
                        
                        if strStatus == "200" {
                            self.constInputView.constant = 0.0
                            self.constCompleteView.constant = 90.0
                            self.stackComplete.isHidden = false
                            self.lbl_Tel.text = self.txtPhoneNum.text
                            
                            self.btnRegisterComplete.isEnabled = true
                        } else if strStatus == "400" {
                            self.navigationController?.view.makeToast("인증번호가 맞지않습니다. 다시 입력해주세요.", duration: 2.0, position: .bottom)
                        } else if strStatus == "401" {
                            self.navigationController?.view.makeToast("휴대폰번호가 맞지않습니다. 다시 입력해주세요.", duration: 2.0, position: .bottom)
                        }
                        
                    } catch {
                        self.alert("requestSMSConfirm = \(value)")
                    }
                }
                
            }
            
            
            
        }
    }
    
    
    func requestUserRegister(provider: String, id: String, email: String, name: String, mobile: String, photoUrl: String) {
        
        self.navigationController?.view.makeToastActivity(.center)
        
        let url = UrlStrings.URL_API_USER_SIGNUP
        
        let param = ["provider": provider,
                     "id": id,
                     "email": email,
                     "name": name,
                     "mobile": mobile,
                     "photo": photoUrl] as [String: Any]
        
        Alamofire.request(url, method: HTTPMethod.post, parameters: param, encoding: URLEncoding.httpBody, headers: nil).responseString { (response) in
            
            self.navigationController?.view.hideToastActivity()
            
            guard response.result.isSuccess else {
                self.alert("\(url) : \(String(describing: response.result.error))")
                return
            }
            
            if let value = response.result.value as NSString? {
                
                if value.isEqual(to: "OK") {
                    let uSession = UserSession()
                    uSession.isLogin = true
                    uSession.mobile = self.lbl_Tel.text
                    uSession.point = 0
                    self.presentingViewController?.dismiss(animated: true, completion: nil)
                    
                } else {
                    self.navigationController?.view.makeToast("이미 가입된 이메일 주소입니다.", duration: 2.0, position: .bottom)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500)) {
                        self.presentingViewController?.dismiss(animated: true, completion: nil)
                    }
                    
                }
                
            }
            
        }
        
    }
    
    
    // MARK: - Btn Action
    @IBAction func onBtnExit(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func onBtnAction(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            btnAll.isSelected = false
        } else {
            sender.isSelected = true
            
            if btnPF.isSelected && btnPersonal.isSelected && btnLocation.isSelected {
                self.onBtnAll(btnAll)
            }
        }
    }
    
    
    
    
    
    @IBAction func onBtnAll(_ sender: UIButton) {
        
        if sender.isSelected {
            sender.isSelected = false
            btnPF.isSelected = false
            btnPersonal.isSelected = false
            btnLocation.isSelected = false
        } else {
            sender.isSelected = true
            btnPF.isSelected = true
            btnPersonal.isSelected = true
            btnLocation.isSelected = true
//            btnAll.isSelected = true
        }
    }
    
    
    @IBAction func onBtnPushAgreeInfoVC(_ sender: UIButton) {
        if let agreeVC = self.storyboard?.instantiateViewController(withIdentifier: "AgreeInfoVC") as? AgreeInfoVC {
            agreeVC.nTag = sender.tag
            self.navigationController?.pushViewController(agreeVC, animated: true)
        }
    }
    
    @IBAction func onBtnSMS(_ sender: UIButton) {
        
        txtPhoneNum.resignFirstResponder()
        txtAuthNum.resignFirstResponder()
        
        
        txtPhoneNum.text = "01032433956"    // Test
        
        guard let phone = txtPhoneNum.text, false == phone.isEmpty else {
            self.navigationController?.view.makeToast("휴대폰번호를 입력해주세요.", duration: 2.0, position: .bottom)
            return
        }
        
        self.requestSMSSend(phone: phone)
    }
    
    @IBAction func onBtnConfirm(_ sender: UIButton) {
        
        txtPhoneNum.resignFirstResponder()
        txtAuthNum.resignFirstResponder()
        
        guard let phone = txtPhoneNum.text, false == phone.isEmpty,  let code = txtAuthNum.text, false == code.isEmpty else {
            self.navigationController?.view.makeToast("번호를 입력해주세요.", duration: 2.0, position: .bottom)
            return
        }
        
        
        self.requestSMSConfirm(phone: phone, code: code)
        
    }
    
    @IBAction func onBtnRegisterComplete(_ sender: UIButton) {
        
        if btnAll.isSelected {
//            UserSession().isLogin = true
//            self.presentingViewController?.dismiss(animated: true, completion: nil)
            
            let uSession = UserSession()
            if let provider = uSession.provider, let id = uSession.authId, let email = uSession.email, let name = uSession.name, let mobile = self.lbl_Tel.text, let photoUrl = uSession.photoUrl {
                self.requestUserRegister(provider: provider, id: id, email: email, name: name, mobile: mobile, photoUrl: photoUrl)
            }
        } else {
            self.navigationController?.view.makeToast("이용약관에 확인해주세요.", duration: 2.0, position: .bottom)
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


extension Dictionary {
    var json: String {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
    
    func dict2json() -> String {
        return json
    }
}
