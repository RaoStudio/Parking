//
//  CardVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 7. 27..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class CardVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var contentsView: UIView!
    
    @IBOutlet weak var lbl_LastPay: UILabel!
    
    
    @IBOutlet weak var txtCard_One: UITextField!
    @IBOutlet weak var txtCard_Two: UITextField!
    @IBOutlet weak var txtCard_Three: UITextField!
    @IBOutlet weak var txtCard_Four: UITextField!
    
    @IBOutlet weak var txtMonth: UITextField!
    @IBOutlet weak var txtYear: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var txtBirth: UITextField!
    
    let uinfo = UserInfoManager()
    let uSession = UserSession()
    
    var strPoint: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "카드 결제"
        
        txtCard_One.delegate = self
        txtCard_Two.delegate = self
        txtCard_Three.delegate = self
        txtCard_Four.delegate = self
        
        txtMonth.delegate = self
        txtYear.delegate = self
        
        txtPassword.delegate = self
        
        txtBirth.delegate = self
        
        
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
        
        
        txtCard_One.inputAccessoryView = toolBar
        txtCard_Two.inputAccessoryView = toolBar
        txtCard_Three.inputAccessoryView = toolBar
        txtCard_Four.inputAccessoryView = toolBar
        
        txtMonth.inputAccessoryView = toolBar
        txtYear.inputAccessoryView = toolBar
        
        txtPassword.inputAccessoryView = toolBar
        
        txtBirth.inputAccessoryView = toolBar
        
        
        if let strLastPay = uinfo.lastPay {
            self.lbl_LastPay.text = "\(strLastPay.decimalPresent) 원"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        
        txtCard_One.text = uinfo.creditOne ?? ""
        txtCard_Two.text = uinfo.creditTwo ?? ""
        txtCard_Three.text = uinfo.creditThree ?? ""
        txtCard_Four.text = uinfo.creditFour ?? ""
        
        txtMonth.text = uinfo.creditMonth ?? ""
        txtYear.text = uinfo.creditYear ?? ""
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
    
    
    @objc func sendCodeBtnAction(sender: UIBarButtonItem){
        txtCard_One.resignFirstResponder()
        txtCard_Two.resignFirstResponder()
        txtCard_Three.resignFirstResponder()
        txtCard_Four.resignFirstResponder()
        
        txtMonth.resignFirstResponder()
        txtYear.resignFirstResponder()
        
        txtPassword.resignFirstResponder()
        
        txtBirth.resignFirstResponder()
    }
    
    // MARK: NotificationCenter
    @objc func keyboardWillHide() {
        self.contentsView.frame.origin.y = 0
    }
    
    @objc func keyboardWillChange(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            
             if (txtPassword.isFirstResponder || txtBirth.isFirstResponder ){
                self.contentsView.frame.origin.y = -(keyboardSize.height/2)
             }
            
        }
    }

    // MARK: - Btn Action
    @IBAction func onBtnPay(_ sender: Any) {
        /*
        intent.putExtra( "CardNum", cardNum );
        intent.putExtra( "CardExpMonth", cardExpMonth );
        intent.putExtra( "CardExpYear", cardExpYear );
        intent.putExtra( "CardAuthNum", cardAuthNum );
        intent.putExtra( "CardPwd", cardPwd );;
        intent.putExtra( "CardQuota", "0" );
         
         + "&CardNum=" + URLEncoder.encode(CardNum, "UTF-8")
         + "&CardExpMonth=" + URLEncoder.encode(CardExpMonth, "UTF-8")
         + "&CardExpYear=" + URLEncoder.encode(CardExpYear, "UTF-8")
         + "&CardAuthNum=" + URLEncoder.encode(CardAuthNum, "UTF-8")
         + "&CardPwd=" + URLEncoder.encode(CardPwd, "UTF-8")
         + "&CardQuota=" + URLEncoder.encode(CardQuota, "UTF-8")
         
 */
        
        var strParam: String = ""
        let strCardNum = txtCard_One.text! + txtCard_Two.text! + txtCard_Three.text! + txtCard_Four.text!
        let strCardExpMonth = txtMonth.text!
        let strCardExpYear = txtYear.text!
        let strAuthNum = txtBirth.text!
        let strCardPwd = txtPassword.text!
        
        
        if let niceVC = self.storyboard?.instantiateViewController(withIdentifier: "NicePayVC") as? NicePayVC {
            
            strParam = "&BuyerName=\(uSession.name!)"
                + "&BuyerTel=\(uSession.mobile!)" + "&BuyerEmail=\(uSession.email!)"
                + "&member_sid=\(uSession.sid!)" + "&parkinglot_sid=\(uinfo.lotSid!)"
                + "&reserve_type=\(uinfo.rsvType!)" + "&begin=\(uinfo.startTime!)"
                + "&end=\(uinfo.endTime!)" + "&price_ori=\(uinfo.totalPay!)"
                + "&point=\(strPoint)" + "&type=nice_card"
                + "&CardNum=\(strCardNum)"
                + "&CardExpMonth=\(strCardExpMonth)"
                + "&CardExpYear=\(strCardExpYear)"
                + "&CardAuthNum=\(strAuthNum)"
                + "&CardPwd=\(strCardPwd)"
                + "&CardQuota=0"
            
            niceVC.param = strParam
            
            self.navigationController?.pushViewController(niceVC, animated: true)
            
            uinfo.creditOne = txtCard_One.text!
            uinfo.creditTwo = txtCard_Two.text!
            uinfo.creditThree = txtCard_Three.text!
            uinfo.creditFour = txtCard_Four.text!
            
            uinfo.creditMonth = strCardExpMonth
            uinfo.creditYear = strCardExpYear
        }
    }
    
    
    
    // MARK: - UITextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        /*
        if textField.isEqual(self.txtCarName) {
            self.txtCarNum.becomeFirstResponder()
        } else {
            tapMyView(self.view)
        }
 */
        
        txtCard_One.resignFirstResponder()
        txtCard_Two.resignFirstResponder()
        txtCard_Three.resignFirstResponder()
        txtCard_Four.resignFirstResponder()
        
        txtMonth.resignFirstResponder()
        txtYear.resignFirstResponder()
        
        txtPassword.resignFirstResponder()
        
        txtBirth.resignFirstResponder()
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text, let textRange = Range(range, in:text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            print("Update : \(updatedText)")
            
            if textField == txtCard_One, updatedText.count > 4 {
                txtCard_Two.becomeFirstResponder()
                return false
            }
            else if textField == txtCard_Two, updatedText.count > 4 {
                txtCard_Three.becomeFirstResponder()
                return false
            }
            else if textField == txtCard_Three, updatedText.count > 4 {
                txtCard_Four.becomeFirstResponder()
                return false
            }
            else if textField == txtCard_Four, updatedText.count > 4 {
                txtMonth.becomeFirstResponder()
                return false
            }
            else if textField == txtMonth, updatedText.count > 2 {
                txtYear.becomeFirstResponder()
                return false
            }
            else if textField == txtYear, updatedText.count > 2 {
                txtPassword.becomeFirstResponder()
                return false
            }
            else if textField == txtPassword, updatedText.count > 2 {
                txtBirth.becomeFirstResponder()
                return false
            }
            else if textField == txtBirth, updatedText.count > 10 {
                return false
            }
            
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        print("\(textField.text)")
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
