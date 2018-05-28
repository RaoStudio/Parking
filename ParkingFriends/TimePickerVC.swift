//
//  TimePickerVC.swift
//  ParkingFriends
//
//  Created by MyoungHyoun Cho on 2018. 5. 15..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class TimePickerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "주차시간 선택"
        
        /*
        if let nItem = self.navigationController?.navigationItem {
            nItem.title = "주차시간 선택"
        }
         */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Action
    @IBAction func onBtnExit(_ sender: Any) {
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
