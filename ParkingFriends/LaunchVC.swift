//
//  LaunchVC.swift
//  ParkingFriends
//
//  Created by Misco on 2018. 6. 29..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit

class LaunchVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
            
            
            /*
            guard let mainNavi = self.storyboard?.instantiateViewController(withIdentifier: "MainNavi") as? UINavigationController else {
                return
            }
            
            self.present(mainNavi, animated: true, completion: nil)
             */
            
            self.navigationController?.navigationBar.isHidden = false
            
            self.willMove(toParentViewController: nil)
            self.removeFromParentViewController()
            self.view.removeFromSuperview()
            self.didMove(toParentViewController: nil)
            
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
