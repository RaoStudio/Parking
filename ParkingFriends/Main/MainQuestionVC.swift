//
//  MainQuestionVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 9. 11..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class MainQuestionVC: PresentTestVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Btn Action
    
    @IBAction func onBtnExit(_ sender: UIButton) {
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
