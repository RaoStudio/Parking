//
//  RegisterVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 6. 22..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {

    
    @IBOutlet weak var constInputView: NSLayoutConstraint!      // Orig ( 200 )
    @IBOutlet weak var constCompleteView: NSLayoutConstraint!   // Orig ( 90 )
    @IBOutlet weak var stackComplete: UIStackView!
    
    
    
    @IBOutlet weak var txtPhoneNum: UITextField!
    @IBOutlet weak var txtAuthNum: UITextField!
    
    @IBOutlet weak var lbl_Tel: UILabel!
    
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
    
    @IBAction func onBtnExit(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
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
