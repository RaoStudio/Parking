//
//  ParkingLotVC.swift
//  ParkingFriends
//
//  Created by MyoungHyoun Cho on 2018. 5. 16..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import TabPageViewController

class ParkingLotVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "주차장목록"
        
        
        let tabPageVC = TabPageViewController.create()
        let vc1 = UIViewController()
        vc1.view.backgroundColor = UIColor.white
        let vc2 = UIViewController()
        vc2.view.backgroundColor = UIColor.blue
        
        tabPageVC.tabItems = [(vc1, "거리순"), (vc2, "요금순")]
        tabPageVC.option.tabWidth = view.frame.width / CGFloat(tabPageVC.tabItems.count)
//        tabPageVC.option.hidesTopViewOnSwipeType = .all
        
//        self.navigationController?.pushViewController(tabPageVC, animated: true)
        
        
        self.addChildViewController(tabPageVC)
        self.view.addSubview(tabPageVC.view)
        tabPageVC.didMove(toParentViewController: self)
        
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
