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
    
    @IBOutlet weak var txtCard_One: UITextField!
    @IBOutlet weak var txtCard_Two: UITextField!
    @IBOutlet weak var txtCard_Three: UITextField!
    @IBOutlet weak var txtCard_Four: UITextField!
    
    @IBOutlet weak var txtMonth: UITextField!
    @IBOutlet weak var txtYear: UITextField!
    
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
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
    }
    
    // MARK: NotificationCenter
    @objc func keyboardWillHide() {
        self.contentsView.frame.origin.y = 0
    }
    
    @objc func keyboardWillChange(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            self.contentsView.frame.origin.y = -(keyboardSize.height/2)
            
            /*
             if (txtCarName.isFirstResponder || txtCarNum.isFirstResponder ){
             self.view.frame.origin.y = -(keyboardSize.height/2)
             }
             */
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
