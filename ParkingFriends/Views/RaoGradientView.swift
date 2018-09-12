//
//  RaoGradientView.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 9. 12..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

@IBDesignable
class RaoGradientView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareView()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }
    
    
    fileprivate func prepareView() {
        
        let appWindowRect = UIApplication.shared.keyWindow?.bounds ?? UIWindow().bounds
        
        let containerView = UIImageView(frame: CGRect(x: 0, y: 0, width: appWindowRect.width, height: self.frame.height))
        var gradient = CAGradientLayer()
        
        gradient.frame = containerView.frame
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        
        let startColor = hexStringToUIColor(hex: "#22d158")
        let endColor = hexStringToUIColor(hex: "#13b6f7")
        
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        
//        gradient.locations = [0, 1]
        
        containerView.layer.addSublayer(gradient)
        addSubview(containerView)
    }

}
