//
//  DetailVC.swift
//  ParkingFriends
//
//  Created by MyoungHyoun Cho on 2018. 4. 26..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet var lbl_Test: UILabel!
    
    var dicPlace: Dictionary<String, Any>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lbl_Test.text = dicPlace?.description
    }

    @IBAction func onExit(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
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
