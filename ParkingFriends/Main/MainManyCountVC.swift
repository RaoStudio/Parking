//
//  MainManyCountVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 8. 31..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class MainManyCountVC: PresentTestVC {

    var strCount: String = ""
    @IBOutlet weak var lblCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        lblCount.text = strCount
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
