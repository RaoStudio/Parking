//
//  ProfileVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 7. 23..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var ivThumb: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.ivThumb.layer.cornerRadius = self.ivThumb.frame.width/2
        self.ivThumb.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Btn Action
    
    @IBAction func onBtnExit(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
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
