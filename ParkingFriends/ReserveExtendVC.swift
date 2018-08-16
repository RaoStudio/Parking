//
//  ReserveExtendVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 8. 16..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class ReserveExtendVC: PresentTestVC {

    @IBOutlet weak var segControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        segControl.layer.cornerRadius = 16
        segControl.layer.borderWidth = 1
        segControl.layer.borderColor = segControl.tintColor.cgColor
        segControl.layer.masksToBounds = true
        
        segControl.setEnabled(false, forSegmentAt: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Btn Action
    
    @IBAction func onBtnCancel(_ sender: UIButton) {
        self.tapMainView(self.view)
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
