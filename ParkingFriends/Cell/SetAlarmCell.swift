//
//  SetAlarmCell.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 7. 4..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class SetAlarmCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var roundView: RoundView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
