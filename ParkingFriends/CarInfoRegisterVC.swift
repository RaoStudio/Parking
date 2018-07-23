//
//  CarInfoRegisterVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 7. 20..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import Alamofire

class CarInfoRegisterVC: PresentTestVC, UITextFieldDelegate {

    @IBOutlet weak var txtCarName: UITextField!
    @IBOutlet weak var txtCarNum: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        txtCarName.delegate = self
        txtCarNum.delegate = self
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapMyView(_:)))
        self.view.addGestureRecognizer(tap)
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
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
    @objc func keyboardWillChange(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if (txtCarName.isFirstResponder || txtCarNum.isFirstResponder ){
                self.view.frame.origin.y = -(keyboardSize.height/2)
            }
        }
    }

    @objc func tapMyView(_ sender : UIView) {
        txtCarName.resignFirstResponder()
        txtCarNum.resignFirstResponder()
    }
    
    // MARK: - API ( URL_API_USER_CARINFO )
    func requestUserCarInfoCahnge(strName: String, strNum: String) {
     
        self.view.makeToastActivity(.center)
        
        let param = ["car_name": strName,
                     "car_num": strNum] as [String: Any]
        
        
        Alamofire.request(UrlStrings.URL_API_USER_CARINFO, method: HTTPMethod.post, parameters: param, encoding: URLEncoding.httpBody, headers: nil).responseString { (response) in
        
            self.view.hideToastActivity()
            
            guard response.result.isSuccess else {
                self.alert("\(UrlStrings.URL_API_USER_CARINFO) : \(String(describing: response.result.error))")
                return
            }
            
            if let value = response.result.value as NSString? {
                /*
                if value.isEqual(to: "OK") {
                    
                    let uSession = UserSession()
                    uSession.carName = strName
                    uSession.carNum = strNum
                    self.tapMainView(self.view)
                } else {
                    self.view.makeToast("차량 정보 업데이트 실패!", duration: 2.0, position: .bottom)
                }
                 */
                
                let uSession = UserSession()
                uSession.carName = strName
                uSession.carNum = strNum
                self.tapMainView(self.view)
                
            }
        }
    }
    
    
    // MARK: - Btn Action
    
    @IBAction func onBtnCancel(_ sender: UIButton) {
        self.tapMainView(self.view)
    }
    
    
    @IBAction func onBtnOk(_ sender: UIButton) {
        if let strName = txtCarName.text, let strNum = txtCarNum.text, !strName.isEmpty, !strNum.isEmpty {
            requestUserCarInfoCahnge(strName: strName, strNum: strNum)
        } else {
            
            if txtCarNum.isFirstResponder || txtCarName.isFirstResponder {
                self.view.makeToast("정보를 입력해주세요.", duration: 2.0, position: .downCenter)
            } else {
                self.view.makeToast("정보를 입력해주세요.", duration: 2.0, position: .bottom)
            }
        }
    }
    
    
    // MARK: - UITextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.isEqual(self.txtCarName) {
            self.txtCarNum.becomeFirstResponder()
        } else {
            tapMyView(self.view)
        }
        
        return true
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
