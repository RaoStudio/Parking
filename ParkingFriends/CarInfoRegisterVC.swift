//
//  CarInfoRegisterVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 7. 20..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class CarInfoRegisterVC: PresentTestVC {

    @IBOutlet weak var txtCarName: UITextField!
    @IBOutlet weak var txtCarNum: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
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
    
    // MARK: - Btn Action
    
    
    @IBAction func onBtnCancel(_ sender: UIButton) {
        self.tapMainView(self.view)
    }
    
    
    @IBAction func onBtnOk(_ sender: UIButton) {
        
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
