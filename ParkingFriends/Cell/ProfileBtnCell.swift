//
//  ProfileBtnCell.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 7. 23..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

protocol RegisterBtnDelegate {
    func onRegisterBtn(at index:IndexPath)
}

class ProfileBtnCell: UITableViewCell {

    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_Contents: UILabel!
    var indexPath: IndexPath!
    var delegate: RegisterBtnDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onBtnRegister(_ sender: UIButton) {
        self.delegate.onRegisterBtn(at: indexPath)
    }
}
