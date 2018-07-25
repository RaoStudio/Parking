//
//  PaymentPointInputCell.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 7. 25..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class PaymentPointInputCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var lbl_Point: UILabel!
    @IBOutlet weak var txt_Point: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        txt_Point.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: Txt Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }

}
