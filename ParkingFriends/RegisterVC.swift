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
                if let dataFromString = value.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false) {
                    
                    do {
                        let json = try JSON(data: dataFromString)
                    } catch {
                        self.alert("requestUserLogin = \(value)")
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
        
        guard let phone = txtPhoneNum.text, false == phone.isEmpty else {
            self.navigationController?.view.makeToast("휴대폰번호를 입력해주세요.", duration: 2.0, position: .bottom)
            return
        }
        
        self.requestSMSSend(phone: phone)
    }
    
    @IBAction func onBtnConfirm(_ sender: UIButton) {
    }
    
    @IBAction func onBtnRegisterComplete(_ sender: UIButton) {
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
