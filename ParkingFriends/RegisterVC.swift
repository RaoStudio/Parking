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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
