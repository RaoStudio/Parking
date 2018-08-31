//
//  MarkerView.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 8. 31..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class MarkerView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        
    }
}
