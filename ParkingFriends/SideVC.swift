//
//  SideVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 6. 25..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class SideVC: UIViewController {

    @IBOutlet weak var constLogout: NSLayoutConstraint!     // orig 187
    @IBOutlet weak var constLogin: NSLayoutConstraint!      // orig 173
    
    
    @IBOutlet weak var ivThumb: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPoint: UILabel!
    @IBOutlet weak var lblCar: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func onBtnLogin(_ sender: UIButton) {
        if let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC {
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
    }
    
    @IBAction func onBtnSetting(_ sender: UIButton) {
    }
    
    @IBAction func onBtnFaq(_ sender: UIButton) {
    }
    
    @IBAction func onBtnQuestion(_ sender: UIButton) {
    }
    
    
    @IBAction func onBtnTest(_ sender: Any) {
        guard let RegisterNavi = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as? UINavigationController else {
            return
        }
        
        self.present(RegisterNavi, animated: true, completion: nil)
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
