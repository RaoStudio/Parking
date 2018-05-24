//
//  CustomView.swift
//  ParkingFriends
//
//  Created by MyoungHyoun Cho on 2018. 5. 24..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class CustomView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        comonInitialization()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        comonInitialization()
    }
    
    func comonInitialization() {
        let nibs = Bundle.main.loadNibNamed("CustomView", owner: self, options: nil)
        if let view = nibs?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }

}
