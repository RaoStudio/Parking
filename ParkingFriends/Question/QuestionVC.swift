//
//  QuestionVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 8. 23..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import DropDown
import Alamofire

class QuestionVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var contentsView: UIView!
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var btnWard: UIButton!
    @IBOutlet weak var btnAccept: UIButton!
    
    
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblWard: UILabel!
    
    
    @IBOutlet weak var txtPhone: UITextField!
    
    
    let wardDropDown = DropDown()
    
    var tap: UIGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupWardDropDown()
        
        
        txtPhone.delegate = self
        
        var btnDone = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.sendCodeBtnAction(sender:)))
        btnDone.tintColor = UIColor.black
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        toolBar.items = [
            btnDone
        ]
        
        
        txtPhone.inputAccessoryView = toolBar
        
        
        tap = UITapGestureRecognizer(target: self, action: #selector(tapMyView(_:)))
        self.view.addGestureRecognizer(tap!)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        self.view.removeGestureRecognizer(tap!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: NotificationCenter & objc function
    @objc func keyboardWillHide() {
        self.topView.frame.origin.y = 0
    }
    
    @objc func keyboardWillChange(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            
            if (txtPhone.isFirstResponder){
                self.topView.frame.origin.y = -(keyboardSize.height/2)
            }
            
        }
    }
    
    @objc func sendCodeBtnAction(sender: UIBarButtonItem){
        txtPhone.resignFirstResponder()
    }
    
    @objc func tapMyView(_ sender : UIView) {
        txtPhone.resignFirstResponder()
    }
    
    // MARK: - Setup DropDown
    func setupWardDropDown() {
        
        wardDropDown.textFont = UIFont.systemFont(ofSize: 13)
        wardDropDown.anchorView = self.btnWard
        wardDropDown.bottomOffset = CGPoint(x: 0, y: self.btnWard.bounds.height)
        
        
        var arrData: Array = [String]()
        
        for item in SeoulType.allValues {
            arrData.append(item.rawValue)
        }
        
        wardDropDown.dataSource = arrData
        
        wardDropDown.selectRow(0)
        lblWard.text = arrData.first
        
        wardDropDown.direction = .bottom
        
        wardDropDown.selectionAction = { [weak self] (index, item) in
            self?.lblWard.text = item
        }
    }
    
    // MARK: - API Call ( URL_PARTNER_CONTRACT )
    func requestPartnerContact(strAddr: String, strPhone: String) {
        self.navigationController?.view.makeToastActivity(.center)
        
//        let url = UrlStrings.URL_PARTNER_CONTRACT + "?pNum=\(strPhone)&addr=\(strAddr)"
        let url = UrlStrings.URL_PARTNER_CONTRACT
        
//        let param = ["pNum": strPhone, "addr": strAddr] as [String: Any]
        
        let param = ["pNum": strPhone, "addr": strAddr]
        
        
        Alamofire.request(url, method: HTTPMethod.get, parameters: param, encoding: URLEncoding.default, headers: nil).validate().responseJSON { (response) in
//        Alamofire.request(url).responseJSON { (response) in
        
            
        
            self.navigationController?.view.hideToastActivity()
        
            guard response.result.isSuccess else {
                print("\(UrlStrings.URL_PARTNER_CONTRACT) : \(String(describing: response.result.error))")
                self.alert("\(UrlStrings.URL_PARTNER_CONTRACT) : \(String(describing: response.result.error))")
                
                
                return
            }
            
            if let value = response.result.value as? Dictionary<String, Any> {
                print("requestPartnerContact JSON = \(value)")
                
             
                if let strStatus = value["status"] as? String {
                    if strStatus == "200" {
                        self.alert("문의 하였습니다. 감사합니다.") {
                            self.presentingViewController?.dismiss(animated: true, completion: nil)
                        }
                    } else {
                        self.alert("현재 정상적인 처리가 되지 않았습니다. 잠시후 다시 시도해 주세요.")
                    }
                }
            }
        }
    }
    
    
    
    // MARK: - Btn Action
    @IBAction func onBtnExit(_ sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onBtnWard(_ sender: UIButton) {
        wardDropDown.show()
    }
    
    @IBAction func onBtnAccept(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func onBtnQuestion(_ sender: UIButton) {
        
        if !btnAccept.isSelected {
            self.alert("개인정보 취급방침에 동의해 주세요 ~ ")
        }
        
        
        if let strPhone = txtPhone.text, let strWard = lblWard.text, !strPhone.isEmpty, strPhone.count >= 11 {
//            self.requestPartnerContact(strAddr: "서울시(도)\(strWard)", strPhone: strPhone)
            self.requestPartnerContact(strAddr: "서울 \(strWard)", strPhone: strPhone)
        } else {
            self.alert("연락처를 확인하세요~ ")
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
