//
//  ParkingLotCell.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 7. 9..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class ParkingLotCell: UITableViewCell {

    
    @IBOutlet weak var lbl_available: UILabel!
    @IBOutlet weak var lbl_capacity: UILabel!
    @IBOutlet weak var lbl_trans1: UILabel!
    
    
    @IBOutlet weak var lbl_company: UILabel!
    @IBOutlet weak var lbl_address: UILabel!
    @IBOutlet weak var lbl_trans2: UILabel!
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
