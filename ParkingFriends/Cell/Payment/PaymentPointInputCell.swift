//
//  PaymentPointInputCell.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 7. 25..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

protocol PaymentPointInput {
    func onPointChange(strPoint: String)
}

class PaymentPointInputCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var lbl_Point: UILabel!
    @IBOutlet weak var txt_Point: UITextField!
    
    var delegate: PaymentPointInput?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        txt_Point.delegate = self
        
        
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
        
        
        txt_Point.inputAccessoryView = toolBar
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @objc func sendCodeBtnAction(sender: UIBarButtonItem){
        txt_Point.resignFirstResponder()
    }
    
    // MARK: Txt Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        print("\(textField.text)")
//        print("\(string)")
        
        if let strTxt = textField.text {
            let strSend = String(format: "%@%@", strTxt, string)
            print(strSend)
            self.delegate?.onPointChange(strPoint: strSend)
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("\(textField.text)")
    }

}
