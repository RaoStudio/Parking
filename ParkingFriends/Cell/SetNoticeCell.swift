//
//  SetNoticeCell.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 7. 4..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class SetNoticeCell: UITableViewCell {

    
    @IBOutlet weak var btnCheck: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onBtnCheck(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
        
//        sender.isSelected = !(sender.isSelected)
    }
}
