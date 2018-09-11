//
//  UnderlinedLabel.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 9. 11..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

@IBDesignable
class UnderlinedLabel: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override var text: String? {
        didSet {
            guard let text = text else { return }
            
            let textRange = NSMakeRange(0, text.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: textRange)
            
            self.attributedText = attributedText
            
        }
    }

}
