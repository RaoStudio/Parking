//
//  PaymentSelectCell.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 7. 24..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

protocol PaymentSelectProtocol { 
    func onPaymentSelct(nTag: Int) 
}

class PaymentSelectCell: UITableViewCell {

    var nTag: Int = 0
    var delegate: PaymentSelectProtocol?
    
    @IBOutlet weak var btnCreditCard: UIButton!
    @IBOutlet weak var btnCellular: UIButton!
    @IBOutlet weak var btnAccount: UIButton!
    @IBOutlet weak var btnKakao: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func onBtnSelect(_ sender: UIButton) {
        
        btnCreditCard.isSelected = false
        btnCellular.isSelected = false
        btnAccount.isSelected = false
        btnKakao.isSelected = false
        
        
        sender.isSelected = true
        
        self.nTag = sender.tag
        
        self.delegate?.onPaymentSelct(nTag: self.nTag)
    }
    
}
