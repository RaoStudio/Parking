//
//  SideMenuCell.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 7. 2..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class SideMenuCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnCount: UIButton!
    @IBOutlet weak var constCellEventBtnWidth: NSLayoutConstraint!      // orig 11
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
