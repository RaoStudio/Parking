//
//  LoginVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 6. 12..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Login"
        
        self.navigationController?.navigationBar.isHidden = true
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapMyView(_:)))
        self.view.addGestureRecognizer(tap)
        self.navigationController?.navigationBar.isTranslucent = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func tapMyView(_ sender : UIView) {
        
        if let bHidden = self.navigationController?.navigationBar.isHidden {
            if bHidden {
                self.navigationController?.navigationBar.isHidden = false
            } else {
                self.navigationController?.navigationBar.isHidden = true
            }
        }
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
