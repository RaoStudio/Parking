//
//  PublicView.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 9. 3..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class PublicView: UIView {

    @IBOutlet weak var ivMarker: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    class func instanceFromNib() -> PublicView {
        return UINib(nibName: "PublicView", bundle: nil).instantiate(withOwner: self, options: nil).first as! PublicView
    }

}
