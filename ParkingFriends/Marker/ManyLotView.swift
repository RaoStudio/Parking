//
//  ManyLotView.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 8. 31..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class ManyLotView: MarkerView {

    
    @IBOutlet weak var contentsView: UIView!
    @IBOutlet weak var lblCount: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func commonInit() {
//        Bundle.main.loadNibNamed("ManyLotView", owner: self, options: nil)
        /*
        addSubview(contentsView)
        contentsView.frame = self.bounds
        contentsView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
 */
      
        
        /*
        contentsView = UINib(nibName: "ManyLotView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        
        addSubview(contentsView)
 */
        
        print("CommonInit~")
    }
    
    class func instanceFromNib() -> ManyLotView {
        return UINib(nibName: "ManyLotView", bundle: nil).instantiate(withOwner: self, options: nil).first as! ManyLotView
    }

}
