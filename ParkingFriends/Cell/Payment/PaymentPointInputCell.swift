//
//  PaymentPointInputCell.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 7. 25..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class PaymentPointInputCell: UITableViewCell {

    @IBOutlet weak var lbl_Point: UILabel!
    @IBOutlet weak var txt_Point: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
