//
//  ProfileBtnCell.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 7. 23..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class ProfileBtnCell: UITableViewCell {

    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_Contents: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
