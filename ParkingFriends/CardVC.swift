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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "카드 결제"
        
        txtCard_One.delegate = self
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
