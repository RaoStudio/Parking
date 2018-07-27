//
//  PaymentPointInputCell.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 7. 25..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

protocol PaymentPointInputProtocol {
    func onPointChange(strPoint: String)
}

class PaymentPointInputCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var lbl_Point: UILabel!
    @IBOutlet weak var txt_Point: UITextField!
    
    var delegate: PaymentPointInputProtocol?
    let uSession = UserSession()
    let uinfo = UserInfoManager()
    
    
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
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if let nPoint = uSession.point {
            if nPoint < 0 {
                return false
            }
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        /*
        if let strTxt = textField.text {
            let strSend = String(format: "%@%@", strTxt, string)
            print(strSend)
            print(range)
            self.delegate?.onPointChange(strPoint: strSend)
        }
         */
        
        /*
        if let strTotal = uinfo.totalPay, let strPoint = txt_Point.text, !strPoint.isEmpty {
            let nTotal = Int(strTotal)!
            let nPoint = Int(strPoint)!
            
            if nPoint > nTotal {
                return false
            }
        }
         */
        
        
        if let text = textField.text, let textRange = Range(range, in:text) {
            var updatedText = text.replacingCharacters(in: textRange, with: string)
         
            if let strTotal = uinfo.totalPay, !strTotal.isEmpty, !updatedText.isEmpty {
                let nTotal = Int(strTotal)!
                let nPoint = Int(updatedText)!
                
                if nPoint > nTotal {
                    updatedText = strTotal
                    self.delegate?.onPointChange(strPoint: updatedText)
                    self.txt_Point.text = updatedText
                    return false
                }
            }
            
            if updatedText.isEmpty {
                updatedText = "0"
            }
            self.delegate?.onPointChange(strPoint: updatedText)
            print(updatedText)
        }
        
        
        
        
        return true
    }
    
    /*
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("\(textField.text)")
    }
 */

}
