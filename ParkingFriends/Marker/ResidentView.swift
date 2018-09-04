//
//  ResidentView.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 9. 4..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class ResidentView: UIView {

    @IBOutlet weak var ivMarker: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    class func instanceFromNib() -> ResidentView {
        return UINib(nibName: "ResidentView", bundle: nil).instantiate(withOwner: self, options: nil).first as! ResidentView
    }
    
    func setPrice(strPrice: String) {
        lblPrice.text = strPrice.decimalPresent as String
        
        if let nCount = lblPrice.text?.count {
            if nCount >= 6
            {
                ivMarker.image = UIImage(named: "Marker_Resident_Long")
                self.frame = CGRect(x: 0, y: 0, width: MarkerSize.long.rawValue, height: MarkerSize.height.rawValue)
            } else if nCount >= 5 {
                ivMarker.image = UIImage(named: "Marker_Resident_Normal")
                self.frame = CGRect(x: 0, y: 0, width: MarkerSize.normal.rawValue, height: MarkerSize.height.rawValue)
            } else {
                ivMarker.image = UIImage(named: "Marker_Resident_Short")
                self.frame = CGRect(x: 0, y: 0, width: MarkerSize.short.rawValue, height: MarkerSize.height.rawValue)
                
                if strPrice == "0" {
                    lblPrice.text = "무료"
                }
            }
        }
        
        
    }
    
}
