//
//  ReservHistoryCell.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 8. 8..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class ReservHistoryCell: UITableViewCell {

    @IBOutlet weak var ivLot: UIImageView!
    
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_Status: UILabel!
    @IBOutlet weak var lbl_Address: UILabel!
    @IBOutlet weak var lbl_Time: UILabel!
    @IBOutlet weak var lbl_Price: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
