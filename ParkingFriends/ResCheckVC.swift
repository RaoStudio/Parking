//
//  ResCheckVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 7. 17..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class ResCheckVC: PresentTestVC {

    
    @IBOutlet weak var lbl_Company: UILabel!
    @IBOutlet weak var lbl_ResTime: UILabel!
    @IBOutlet weak var lbl_Pay: UILabel!
    @IBOutlet weak var lbl_CarInfo: UILabel!
    
    @IBOutlet weak var btnAccept: UIButton!
    
    let uinfo = UserInfoManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.lbl_Company.text = uinfo.rCompany
        if let strPay = uinfo.totalPay {
            self.lbl_Pay.text = "\(strPay.decimalPresent) 원"
        }
        
        if let strStart = uinfo.startTime, let strEnd = uinfo.endTime {
            lbl_ResTime.text = "\(strStart) ~ \(strEnd)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: Button Action
    
    @IBAction func onBtnCancel(_ sender: UIButton) {
        
        self.tapMainView(self.view)
    }
    
    @IBAction func onBtnOk(_ sender: UIButton) {
        if btnAccept.isSelected {
            
        } else {
            self.view.makeToast("약관에 동의해주세요.", duration: 2.0, position: .bottom)
        }
    }
    
    @IBAction func onBtnAccept(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    
    @IBAction func onBtnCarInfo(_ sender: UIButton) {
        /*
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "NaviVC") else {
            return
        }
        
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false, completion: nil)
 */
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
