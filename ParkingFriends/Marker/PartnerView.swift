//
//  PartnerView.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 9. 4..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class PartnerView: UIView {

    @IBOutlet weak var ivMarker: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    
    var nStrCount: Int = 0
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    
    class func instanceFromNib() -> PartnerView {
        return UINib(nibName: "PartnerView", bundle: nil).instantiate(withOwner: self, options: nil).first as! PartnerView
    }
    
    func setMarkerView(strPrice: String, bAvailable: Bool) {
        lblPrice.text = strPrice.decimalPresent as String
        
        if let nCount = lblPrice.text?.count {
            
            nStrCount = nCount
            
            if nCount >= 6
            {
                ivMarker.image = UIImage(named: "Marker_Partner_Long")
                self.frame = CGRect(x: 0, y: 0, width: MarkerSize.long.rawValue, height: MarkerSize.height.rawValue)
            } else if nCount >= 5 {
                ivMarker.image = UIImage(named: "Marker_Partner_Normal")
                self.frame = CGRect(x: 0, y: 0, width: MarkerSize.normal.rawValue, height: MarkerSize.height.rawValue)
            } else {
                ivMarker.image = UIImage(named: "Marker_Partner_Short")
                self.frame = CGRect(x: 0, y: 0, width: MarkerSize.short.rawValue, height: MarkerSize.height.rawValue)
                
                if strPrice == "0" {
                    lblPrice.text = "무료"
                }
            }
            
            if bAvailable == false {
                lblPrice.textColor = hexStringToUIColor(hex: "#888888")
                if nCount >= 6 {
                    ivMarker.image = UIImage(named: "Marker_Disable_Long")
                } else if nCount >= 5 {
                    ivMarker.image = UIImage(named: "Marker_Disable_Normal")
                } else {
                    ivMarker.image = UIImage(named: "Marker_Disable_Short")
                }
            }
            
        }
    }
}
