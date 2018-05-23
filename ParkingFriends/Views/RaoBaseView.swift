//
//  RaoBaseView.swift
//  ParkingFriends
//
//  Created by MyoungHyoun Cho on 2018. 5. 23..
//  Copyright © 2018년 rao. All rights reserved.
//

import Foundation
import UIKit

class RaoBaseView: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }
    
    internal class func xibName() -> String {
        return String(describing: self)
    }
    
    fileprivate func prepareView() {
        let nameForXib = RaoBaseView.xibName()
//        let nibs = Bundle.main.loadNibNamed(nameForXib, owner: self, options: [AnyHashable : Any]?)
        let nibs = Bundle.main.loadNibNamed("TestView", owner: self, options: nil)
        if let view = nibs?.first as? UIView {
//            view.backgroundColor = UIColor.red
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubviewWithConstraints(view)
        }
    }
}

extension UIView {
    public func addSubviewWithConstraints(_ subview: UIView, offset: Bool = true) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        let views = ["subview" : subview]
        addSubview(subview)
        
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: offset ? "H:|-[subview]-|" : "H:|-0-[subview]-0-|", options: [.alignAllLeading, .alignAllTrailing], metrics: nil, views: views)
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: offset ? "V:|-[subview]-|" : "V:|-0-[subview]-0-|", options: [.alignAllTop, .alignAllBottom], metrics: nil, views: views))
        NSLayoutConstraint.activate(constraints)
    }
    
}
